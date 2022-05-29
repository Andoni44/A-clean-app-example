//
//  Alert.swift
//  Vivora
//
//  Created by Andoni Da silva on 28/5/22.
//

import UIKit
import ObjectiveC

public extension UIView {
    private struct ToastKeys {
        static var timer        = "com.toast-swift.timer"
        static var completion   = "com.toast-swift.completion"
        static var activeToasts = "com.toast-swift.activeToasts"
    }
    
    private final class ToastCompletionWrapper {
        let completion: ((Bool) -> Void)?
        
        init(_ completion: ((Bool) -> Void)?) {
            self.completion = completion
        }
    }
    
    private var activeToasts: NSMutableArray {
        get {
            if let activeToasts = objc_getAssociatedObject(self, &ToastKeys.activeToasts) as? NSMutableArray {
                return activeToasts
            } else {
                let activeToasts = NSMutableArray()
                objc_setAssociatedObject(self, &ToastKeys.activeToasts, activeToasts, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activeToasts
            }
        }
    }
    
    func createToast(_ parameters: VivoraToast.Parameters,
                     duration: VivoraToastManager.Duration = .long, completion: ((_ didTap: Bool) -> Void)? = nil) {
        
        if activeToasts.count > 0 { return }
        showToast(parameters, duration: duration, completion: completion)
        
    }
    
    // MARK: - Hide Toast Methods

    func hideToast() {
        guard let activeToast = activeToasts.firstObject as? UIView else { return }
        hideToast(activeToast)
    }

    func hideToast(_ toast: UIView) {
        guard activeToasts.contains(toast) else { return }
        hideToast(toast, fromTap: false)
    }
}

// MARK: - Toast Manager

public final class VivoraToastManager {
    public static let shared = VivoraToastManager()
    public var showAnimationTime = 0.1
    public var hideAnimationTime = 0.1
    
    @objc public enum Duration: Int {
        case short
        case long

        internal var inSeconds: Int {
            switch self {
            case .short: return 3
            case .long: return 5

            }
        }
    }
}

fileprivate extension UIView {
    func showToast(_ parameters: VivoraToast.Parameters,
                   duration: VivoraToastManager.Duration = .long,
                   completion: ((_ didTap: Bool) -> Void)? = nil) {

        let toast = VivoraToast.loadNib(owner: self)
        objc_setAssociatedObject(toast, &ToastKeys.completion,
                                 ToastCompletionWrapper(completion),
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        showToast(parameters, toast, duration: duration)
    }


    // MARK: Show/Hide Methods

   func showToast(_ parameters: VivoraToast.Parameters,
                  _ toast: VivoraToast,
                  duration: VivoraToastManager.Duration = .long) {
        let statusBarView = configureStatusBarView()
        let toast = configureToastView(parameters: parameters, toast: toast)

        activeToasts.add(toast)

        toast.transform = CGAffineTransform(translationX: 0, y: -toast.frame.height)
        UIView.animate(withDuration: VivoraToastManager.shared.showAnimationTime,
                       delay: 0.0,
                       options: .curveEaseIn, animations: {
            statusBarView.alpha = 1.0
            toast.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: { _ in
            let timer = Timer(timeInterval: TimeInterval(duration.inSeconds), target: self, selector: #selector(UIView.toastTimerDidFinish(_:)), userInfo: toast, repeats: false)
            RunLoop.main.add(timer, forMode: .common)
            objc_setAssociatedObject(toast, &ToastKeys.timer, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        })
    }

    func hideToast(_ toast: UIView, fromTap: Bool) {
        if let timer = objc_getAssociatedObject(toast, &ToastKeys.timer) as? Timer {
            timer.invalidate()
        }

        UIView.animate(withDuration: VivoraToastManager.shared.hideAnimationTime, delay: 0.0, options: .curveEaseIn,
                       animations: {
            toast.transform = CGAffineTransform(translationX: 0, y: -toast.frame.height)
        }, completion: { _ in
            toast.removeFromSuperview()
            self.activeToasts.remove(toast)

            if let wrapper = objc_getAssociatedObject(toast, &ToastKeys.completion) as? ToastCompletionWrapper, let completion = wrapper.completion {
                completion(fromTap)
            }
        })
    }

    func configureStatusBarView() -> UIView {
        let statusBarView = UIView(frame: .zero)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.backgroundColor = .white
        self.addSubview(statusBarView)
        statusBarView.alpha = 0.0
        return statusBarView
    }

    func configureToastView(parameters: VivoraToast.Parameters, toast: VivoraToast) -> VivoraToast {
        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.backgroundColor = .white
        self.addSubview(toast)

        NSLayoutConstraint.activate(
            [
                toast.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                toast.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0)
            ]
        )

        toast.set(parameters) { [weak self] tapped in
            if !tapped {
                self?.handleToastTapped(toast)
            }
        }
        return toast
    }

    // MARK: - Events

    func handleToastTapped(_ toast: UIView) {
        hideToast(toast, fromTap: true)
    }

    @objc
    func toastTimerDidFinish(_ timer: Timer) {
        guard let toast = timer.userInfo as? UIView else { return }
        hideToast(toast)
    }
}

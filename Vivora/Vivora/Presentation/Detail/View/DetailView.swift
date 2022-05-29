//
//  DetailView.swift
//  Vivora
//
//  Created by Andoni Da silva on 28/5/22.
//

import UIKit
import Lottie

final class DetailView: BaseVivoraViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionBody: UILabel!
    @IBOutlet weak var descriptionStack: UIStackView!
    @IBOutlet weak var comicsContainer: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var storiesContainer: UIView!
    @IBOutlet weak var eventsContainer: UIView!
    @IBOutlet weak var storiesCollectionViewContainer: UIView!
    @IBOutlet weak var storiesLabel: UILabel!
    @IBOutlet weak var comicsCollectionContainer: UIView!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var eventsCollectionContainer: UIView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var comicsAI: UIActivityIndicatorView!
    @IBOutlet weak var storiesAI: UIActivityIndicatorView!
    @IBOutlet weak var eventsAI: UIActivityIndicatorView!
    
    // MARK: Components
    
    private let presenter: DetailPresenterProtocol
    
    // MARK: - Data
    
    let character: Character
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VivoraLog("Detail view 👁 loaded", tag: .presentation)
        localize()
        presenter.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async { [presenter, character] in
            presenter.getCollectionsData(from: character)
        }
    }
    
    // MARK: Init
    
    init(presenter: DetailPresenterProtocol, character: Character) {
        self.presenter = presenter
        self.character = character
        super.init(nibName: "DetailView", bundle: Bundle(for: HomeView.self))
    }
    
    deinit {
        VivoraLog("Detail view deallocated without leaks 💪🏻", tag: .presentation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

private extension DetailView {
    func localize() {
        descriptionTitle.text = "detail-description".localized
        eventsLabel.text = "detail-events".localized
        comicsLabel.text = "detail-comics".localized
        storiesLabel.text = "detail-stories".localized
    }

    func layoutSetup() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: view.frame.height - 50)
        return layout
    }
}

// MARK: - Childs setup

private extension DetailView {
    func childsSetup(withData data: [String], withLayout layout: UICollectionViewFlowLayout, container: UIView) {
        let child = DetailColectionViewController(withData: data, andLayout: layout)
        addChild(child)
        container.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.anchor(topAnchor: container.topAnchor,
                          trailingAnchor: container.trailingAnchor,
                          bottomAnchor: container.bottomAnchor,
                          leadingAnchor: container.leadingAnchor)
        child.didMove(toParent: self)
    }
}

// MARK: - Output

extension DetailView: DetailPresenterToViewProtocol {
    func displayStaticData() {
        // Customize header
        let headerDetailView = HeaderDetailView()
        if let url = URL(string: character.image) {
            headerDetailView.imageView.sd_setImage(with:  url)
        }
        headerDetailView.nameLabel.text = character.name
        headerView.addSubview(headerDetailView)
        headerDetailView.translatesAutoresizingMaskIntoConstraints = false
        headerDetailView.anchor(topAnchor: headerView.topAnchor,
                                trailingAnchor: headerView.trailingAnchor,
                                bottomAnchor: headerView.bottomAnchor,
                                leadingAnchor: headerView.leadingAnchor)
        descriptionBody.text = character.description.isEmpty ? character.name : character.description
        descriptionBody.textColor = .fontColor
        title = character.name
    }
    
    func displayCollectionViews(fromViewModel model: CollectionDisplayDataModel) {
        if let comics = model.comics, !comics.isEmpty {
            print(comics)
            childsSetup(withData: comics,
                        withLayout: layoutSetup(),
                        container: comicsCollectionContainer)
        } else {
            comicsContainer?.isHidden = true
        }
        if let events = model.events, !events.isEmpty {
            childsSetup(withData: events,
                        withLayout: layoutSetup(),
                        container: eventsCollectionContainer)
        } else {
            eventsContainer?.isHidden = true
        }
        if let stories = model.stories, !stories.isEmpty {
            childsSetup(withData: stories,
                        withLayout: layoutSetup(),
                        container: storiesCollectionViewContainer)
        } else {
            storiesContainer?.isHidden = true
        }
    }
    
    func startAnimation() {
        DispatchQueue.main.async { [comicsAI, eventsAI, storiesAI] in
            [comicsAI, eventsAI, storiesAI].forEach {
                $0?.startAnimating()
            }
        }
    }
    
    func stopAnimation() {
        DispatchQueue.main.async { [comicsAI, eventsAI, storiesAI] in
            [comicsAI, eventsAI, storiesAI].forEach {
                $0?.stopAnimating()
            }
        }
    }
    
    func display(error: String) {
        VivoraLog(error + " 🚨", tag: .presentation)
        DispatchQueue.main.async { [weak self] in
            self?.showErrorToast(title: "Error", message: error, duration: .long)
        }
    }
}

// MARK: - DetailViewProtocol

extension DetailView: DetailViewProtocol {
    
}

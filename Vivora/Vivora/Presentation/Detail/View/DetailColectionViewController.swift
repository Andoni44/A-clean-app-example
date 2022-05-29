//
//  DetailColectionViewController.swift
//  Vivora
//
//  Created by Andoni Da silva on 28/5/22.
//

import UIKit

final class DetailColectionViewController: UICollectionViewController {

    // MARK: Cell ID

    private let cellID = "detailCollectionCell"

    // MARK: - Init
    
    init(withData data: [String], andLayout layout: UICollectionViewFlowLayout) {
        elements = data
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
    }

    //  MARK: - Data

    var elements: [String] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                VivoraLog("Reloading collection data in main thread? \(Thread.isMainThread ? "YES 👌🏻" : "NO 😬")", tag: .presentation)
            }
        }
    }
}

// MARK: - Front

extension DetailColectionViewController {
    func collectionSetup() {
        let nib = UINib(nibName: "DetailCell", bundle: Bundle(for: DetailCell.self))
        collectionView.register(nib, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .clear
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension DetailColectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 160, height: view.frame.height - 50)
    }
}

// MARK: - UICollectionViewDataSource

extension DetailColectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        VivoraLog("Elements has \(elements.count) 👀", tag: .presentation)
        return elements.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? DetailCell
        else { return UICollectionViewCell() }
        cell.configureWith(imageURL: elements[indexPath.item])
        return cell
    }
}

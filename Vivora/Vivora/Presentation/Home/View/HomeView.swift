//
//  HomeView.swift
//  Presentation
//
//  Created by Andoni Da silva on 23/5/22.
//

import UIKit
import Lottie

final class HomeView: BaseVivoraViewController {

    // MARK: Outlets

    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var scrollUpButton: UIButton!
    @IBOutlet private(set) weak var animationView: AnimationView!
    @IBOutlet private(set) weak var noResultsLabel: UILabel!
    @IBOutlet private(set) weak var searchButton: UIButton!
    @IBOutlet weak var selector: UISegmentedControl!

    // MARK: Search controller

    private(set) lazy var searchController = VivoraSearchController(searchResultsController: nil,
                                                          title: "Search any hero...",
                                                          textColor: UIColor.white)

    // MARK: Components

    private let presenter: HomePresenterProtocol

    // MARK: - Cell

    private let cellID = "homeCell"
    private var rawData: CharacterListModel = [] {
        didSet {
            data = isFiltering ? filteredData : rawData
        }
    }

    private var data: CharacterListModel = [] {
        didSet {
            DispatchQueue.main.async { [tableView] in
                tableView?.reloadData()
            }
        }
    }
    

    // MARK: - Offset

    private var offset: Int = 1
    private var filteringOffset: Int = 1
    private var allowNewRequest = true

    // MARK: - Filtering

    var isFiltering: Bool = false

    lazy var filteredData: CharacterListModel = [] {
        didSet {
            data = isFiltering ? filteredData : rawData
        }
    }

    // MARK: Init

    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "HomeView", bundle: Bundle(for: HomeView.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifeycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vívora"
        VivoraLog("HomeView 👁 loaded", tag: .presentation)
        setupAnimation()
        navigationSetup()
        setupTableView()
        searchBarSetup()
        setupButton()
        presenter.viewDidLoad()
        localize()
    }
}

// MARK: - Navigation setup

private extension HomeView {
    func navigationSetup() {
        navigationConfiguration()
        navigationAppearance()
        navigationNavigatioConfiguration()
    }

    func navigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.vivoraMain
        appearance.titleTextAttributes = [.foregroundColor: UIColor.tintColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.tintColor]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.vivoraCell,
                                                                   NSAttributedString.Key.font: UIFont.antonRegular(size: 20)]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                        NSAttributedString.Key.font: UIFont.antonRegular(size: 30)]
    }

    func navigationConfiguration() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func navigationNavigatioConfiguration() {
        let barBackItem = UIBarButtonItem(title: NSLocalizedString("home-back".localized,
                                                                   comment: ""),
                                          style: .plain,
                                          target: nil, action: nil)
        navigationItem.backBarButtonItem = barBackItem
        let menuBtn = UIButton(type: .custom)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        navigationItem.rightBarButtonItem = menuBarItem
    }
}

// MARK: - UI setup

private extension HomeView {
    func localize() {
        searchButton.setTitle("home-empty-search-button".localized, for: .normal)
        searchButton.setTitle("home-empty-search-button".localized, for: .selected)
        noResultsLabel.text = "home-empty-label".localized
        selector.setTitle("home-segment-all".localized, forSegmentAt: 0)
        selector.setTitle("home-segment-favourites".localized, forSegmentAt: 1)
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeCell.self, forCellReuseIdentifier: cellID)
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    func setupButton() {
        scrollUpButton.roundCorners(corners: [.allCorners], radius: 40)
    }

    func setupAnimation() {
        animationView.loopMode = .loop
    }
}

// MARK: - Inner methods

private extension HomeView {
    private func handleBottomReach() {
        allowNewRequest = false
        if !isFiltering {
            offset = offset + 15
            presenter.loadWith(name: "", offset: String(offset))
        } else {
            search()
        }
    }

    func enableSearchButton(enabled: Bool) {
        DispatchQueue.main.async { [searchButton] in
            searchButton?.isEnabled = enabled
        }
    }

    func search() {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        DispatchQueue.global(qos: .userInitiated).async { [presenter, filteringOffset] in
            presenter.loadWith(name: text, offset: String(filteringOffset))
        }
    }


    func loadWith(offset: String, name: String) {
        DispatchQueue.global(qos: .userInitiated).async { [presenter] in
            presenter.loadWith(name: name, offset: offset)
            VivoraLog("Loading offset \(offset)", tag: .presentation)
        }
    }

    func searchBarSetup() {
        configureSearchBar()
    }

    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
}

// MARK: - Actions

private extension HomeView {
    @IBAction func onPageSelected(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }

    @IBAction func onSearch(_ sender: UIButton) {
        enableSearchButton(enabled: false)
        search()
    }

    @IBAction func onScrollUp(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.setContentOffset(.zero, animated: true)
        }
    }
}

// MARK: - TableView Datasource

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? HomeCell
        else { return UITableViewCell() }
        let character = data[indexPath.item]
        cell.configureWith(character: character) { [presenter] in
            DispatchQueue.main.async {
                presenter.navigateTo(characterDetail: character)
            }
        }
        return cell
    }
}

// MARK: - TableView Delegate

extension HomeView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        if contentYoffset > height && scrollUpButton.alpha == 0 {
            scrollUpButton.fadeIn(duration: 0.1)
        }
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height && allowNewRequest == true && !data.isEmpty{
            handleBottomReach()
        }
        guard contentYoffset <= 50.0 && scrollUpButton.alpha == 1 else { return }
        scrollUpButton.fadeOut(duration: 0.1)
    }
}

// MARK: - Output

extension HomeView: HomePresenterToViewProtocol {
    func hideNoResults() {
        DispatchQueue.main.async { [weak self] in
            guard self?.noResultsLabel.alpha == 1 else { return }
            self?.noResultsLabel?.alpha = 0
            self?.searchButton?.alpha = 0
        }
    }

    func showNoResults() {
        DispatchQueue.main.async { [weak self] in
            guard self?.noResultsLabel.alpha == 0 && self?.filteredData.isEmpty ?? false else { return }
            UIView.animate(withDuration: 0.3, delay: 0.0) {
                self?.noResultsLabel?.alpha = 1
                self?.searchButton?.alpha = 1
            }
        }
    }

    func startFiltering() {
        isFiltering = true
    }

    func stopFiltering() {
        isFiltering = false
        filteringOffset = 1
        allowNewRequest = true
    }
    
    func present(characterList list: CharacterListModel) {
        if isFiltering {
            filteredData = filteredData + list
            enableSearchButton(enabled: true)
            filteringOffset = filteringOffset + 15
            VivoraLog("Filtered data updated 👌🏻", tag: .presentation)
        } else {
            rawData = rawData + list
            VivoraLog("Data updated 👌🏻", tag: .presentation)
        }
        allowNewRequest = (isFiltering && !list.isEmpty) || (!isFiltering && !list.isEmpty)
    }

    func display(error: String) {
        VivoraLog(error + " 🚨", tag: .presentation)
        DispatchQueue.main.async { [weak self] in
            self?.showErrorToast(title: "Error", message: error, duration: .long)
        }
    }

    func startAnimation() {
        guard !animationView.isAnimationPlaying else { return }
        DispatchQueue.main.async { [animationView] in
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut) {
                animationView?.alpha = 1
            } completion: { _ in
                animationView?.play()
            }
        }
    }

    func stopAnimation() {
        guard animationView.isAnimationPlaying else { return }
        DispatchQueue.main.async { [animationView] in
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut) {
                animationView?.alpha = 0
            } completion: { _ in
                animationView?.stop()
            }
        }
    }
}

// MARK: Home View

extension HomeView: HomeViewProtocol {
    
}

//MARK: - HomeView Search bar extension

extension HomeView: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filteringOffset = filteringOffset != 1 ? 1 : filteringOffset
        DispatchQueue.main.async { [presenter, rawData, searchController] in
            guard let text = searchController.searchBar.text?.lowercased() else { return }
            DispatchQueue.global(qos: .userInitiated).async {
                presenter.filter(collection: rawData, byCharacterName: text)
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async { [weak self] in
            self?.search()
        }
    }
}

//
//  SearchVC.swift
//  MasterpieceGallery
//
//  Created by Mikhail Ustyantsev on 11.02.2024.
//

import UIKit

final class SearchVC: UIViewController {

    enum Section { case main }
    typealias DataSource = UITableViewDiffableDataSource<Section, Artist>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Artist>
   
    //MARK: - Properties
    
    let tableView           = UITableView()
    var artists: [Artist]   = []
    
    //MARK: - tableView
    private lazy var tableViewDataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureSearchController()
        getData()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }

   
    private func getData() {
        NetworkManager.shared.loadJson { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.artists = data.artists
                    self.applySnapshot(with: data.artists)
                case .failure(let error):
                    print(error.rawValue)
                }
            }
        }
    }
    
    private func  configureTableView() {
        tableView.register(ArtistCell.self, forCellReuseIdentifier: ArtistCell.reuseID)
        tableView.estimatedRowHeight    = UITableView.automaticDimension
        tableView.delegate              = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    func configureSearchController() {
        let searchController                        = UISearchController()
        searchController.searchResultsUpdater       = self
        searchController.searchBar.delegate         = self
        searchController.searchBar.placeholder      = "Search for an artist or a masterpiece"
        navigationItem.hidesSearchBarWhenScrolling  = false
        navigationItem.searchController             = searchController
    }

    // MARK: - DataSource methods
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, artist in
            let cell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.reuseID, for: indexPath) as? ArtistCell
            cell?.set(artist: artist)
            return cell
        }
        return dataSource
    }
    
    private func applySnapshot(with artists: [Artist], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(artists)
        tableViewDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    
    // MARK: - SearchBar filtering methods
    private func filteredArtists(with filter: String?) -> [Artist] {
        guard let filter = filter else { return [] }
        return self.artists.filter { $0.contains(filter)  || containsTextIn(works: $0.works, searchText: filter) }
    }
    
    private func containsTextIn(works: [Work], searchText: String) -> Bool {
        let strings = works.map { $0.title }
        let filteredStrings = strings.filter { $0.lowercased().contains(searchText.lowercased()) }
        return !filteredStrings.isEmpty ? true : false
    }
    
    private func performQuery(with filter: String?) {
        let artists = filteredArtists(with: filter).sorted { $0.name < $1.name }
        applySnapshot(with: artists)
    }
}


extension SearchVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        performQuery(with: text)
    }
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        applySnapshot(with: artists)
    }
}


extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let artist = tableViewDataSource.itemIdentifier(for: indexPath) else { return }
        let artistWorkVC = ArtistWorksVC(works: artist.works)
        navigationController?.pushViewController(artistWorkVC, animated: true)
    }
}

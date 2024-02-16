//
//  ArtistWorksVC.swift
//  MasterpieceGallery
//
//  Created by Mikhail Ustyantsev on 15.02.2024.
//

import UIKit

class ArtistWorksVC: UIViewController {

    let works: [Work]
    
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Work>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Work>
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private lazy var collectionDataSource = makeDataSource()
    
    init(works: [Work]) {
        self.works = works
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        applySnapshot(with: works)
    }

    
    private func  configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(WorkCell.self, forCellWithReuseIdentifier: String(describing: WorkCell.reuseID))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.safeAreaLayoutGuide
    
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: margins.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
    }
    
    
    // MARK: - DataSource methods
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, work) ->
                UICollectionViewCell? in
                
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: WorkCell.self),
                    for: indexPath) as? WorkCell
                cell?.set(image: UIImage(named: work.image))
                return cell
            })
        return dataSource
    }
    
    private func applySnapshot(with works: [Work], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.works)
        collectionDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}


extension ArtistWorksVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let work      = collectionDataSource.itemIdentifier(for: indexPath) else { return }
        
        let destinationVC   = WorkInfoVC(work: work)
        let navController   = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
}

extension ArtistWorksVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

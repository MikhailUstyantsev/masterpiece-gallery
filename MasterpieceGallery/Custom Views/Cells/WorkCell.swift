//
//  WorkCell.swift
//  MasterpieceGallery
//
//  Created by Mikhail Ustyantsev on 15.02.2024.
//

import UIKit

class WorkCell: UICollectionViewCell {
    
    static let reuseID  = "WorkCell"
    private let workImageView   = UIImageView()
    private let symbolImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Interface Builder is not supported!")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        workImageView.image     = nil
        symbolImageView.image   = nil
    }
 
    func set(image: UIImage?) {
        workImageView.image = image
    }
    
    private func configure() {
        workImageView.translatesAutoresizingMaskIntoConstraints     = false
        symbolImageView.translatesAutoresizingMaskIntoConstraints   = false
        
        contentView.addSubview(workImageView)
        contentView.addSubview(symbolImageView)
        
        workImageView.contentMode   = .scaleAspectFit
        symbolImageView.contentMode = .scaleAspectFit
        
        symbolImageView.image       = R.Images.unwrap
        
        NSLayoutConstraint.activate([
            workImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            workImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            workImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            workImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            symbolImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

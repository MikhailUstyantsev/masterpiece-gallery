//
//  ArtistCell.swift
//  MasterpieceGallery
//
//  Created by Mikhail Ustyantsev on 14.02.2024.
//

import UIKit

class ArtistCell: UITableViewCell {

    static let reuseID  = "ArtistCell"
    let artistImageView = UIImageView()
    let titleLabel      = MGTitleLabel(textAlignment: .left, fontSize: 18)
    let bioLabel        = MGBodyLabel(textAlignment: .left)
    let stackView       = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(artist: Artist) {
        artistImageView.image   = UIImage(named: artist.image)
        titleLabel.text         = artist.name
        bioLabel.text           = artist.bio
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistImageView.image   = nil
        titleLabel.text         = nil
        bioLabel.text           = nil
    }
    
    private func configure() {
        contentView.addSubview(artistImageView)
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bioLabel)
        
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        artistImageView.contentMode = .scaleAspectFit
        
        let padding: CGFloat = 8
        let imageToStackPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            artistImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            artistImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            artistImageView.widthAnchor.constraint(equalToConstant: 120),
            artistImageView.heightAnchor.constraint(equalTo: artistImageView.widthAnchor, multiplier: 1.5),
            
            stackView.leadingAnchor.constraint(equalTo: artistImageView.trailingAnchor, constant: imageToStackPadding),
            stackView.topAnchor.constraint(equalTo: artistImageView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    
}

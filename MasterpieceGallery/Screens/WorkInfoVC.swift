//
//  WorkInfoVC.swift
//  MasterpieceGallery
//
//  Created by Mikhail Ustyantsev on 16.02.2024.
//

import UIKit

class WorkInfoVC: UIViewController {
    
    private let workTitle           = MGTitleLabel(textAlignment: .center, fontSize: 24)
    private let workImageView       = UIImageView()
    private let descriptionLabel    = UITextView()
    
    let work: Work
    
    init(work: Work) {
        self.work = work
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        set(with: self.work)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        workImageView.contentMode         = .scaleAspectFit
        descriptionLabel.font             = UIFont.systemFont(ofSize: 18)
        descriptionLabel.textColor        = .secondaryLabel
        
        [workTitle, workImageView, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func layoutUI() {
        view.addSubview(workTitle)
        view.addSubview(workImageView)
        view.addSubview(descriptionLabel)
        
        let margins             = view.safeAreaLayoutGuide
        let padding: CGFloat    = 30
        
        NSLayoutConstraint.activate([
            workTitle.topAnchor.constraint(equalTo: margins.topAnchor),
            workTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            workTitle.heightAnchor.constraint(equalToConstant: 26),
            
            workImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            workImageView.topAnchor.constraint(equalTo: workTitle.bottomAnchor, constant: padding),
            workImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            workImageView.heightAnchor.constraint(equalToConstant: 300),
            
            descriptionLabel.topAnchor.constraint(equalTo: workImageView.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -8),
        ])
    }
    
    private func set(with work: Work) {
        workTitle.text          = work.title
        workImageView.image     = UIImage(named: work.image)
        descriptionLabel.text   = work.info
    }

}

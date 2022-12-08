//
//  NewsViewController.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 09.12.2022.
//

import UIKit

final class NewsViewController: UIViewController {
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        setupNavBar()
        setImageView()
        setTitleLabel()
        setDescriptionLabel()
    }
    
    private func setupNavBar() {
        navigationItem.title = "News"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
      
        navigationItem.leftBarButtonItem?.tintColor = .label
    }
    
    private func setImageView() {
        imageView.image = UIImage(named: "images")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        
        // imageView position
        view.addSubview(imageView)
        imageView.pinLeft(to: view)
        imageView.pinRight(to: view)
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        imageView.pinHeight(to: imageView.widthAnchor)
    }
    
    private func setTitleLabel() {
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
        
        // titleLabel position
        view.addSubview(titleLabel)
        titleLabel.pinTop(to: imageView.bottomAnchor)
        titleLabel.pin(to: view, [.left: 16, .right: 16])
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
    }
    
    private func setDescriptionLabel() {
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.numberOfLines = 0
        
        // descriptionLabel position
        view.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 10)
        descriptionLabel.pin(to: view, [.left: 16, .right: 16])
    }
    
    // public method
    public func configure(with viewModel: NewsViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            viewModel.imageData = imageView.download(from: url)
        }
    }
    
    // objc functions
    @objc
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

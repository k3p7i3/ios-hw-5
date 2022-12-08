//
//  NewsCell.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 06.12.2022.
//

import UIKit

final class NewsCell: UITableViewCell {
    static let reuseIdentifier: String = "NewsCell"
    private let newsImageView = UIImageView()
    private let newsTitleLabel = UILabel()
    private let newsDescriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    
    private func setupImageView() {
        // newsImageView style itself
        newsImageView.layer.cornerRadius = 8
        newsImageView.layer.cornerCurve = .continuous
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(newsImageView)
        
        // newsImageView location relatively to contentView
        newsImageView.pin(to: contentView, [.top: 12, .bottom: 12, .left: 12])
        newsImageView.pinWidth(to: newsImageView.heightAnchor)
    }
    
    private func setupTitleLabel() {
        newsTitleLabel.textColor = .label
        newsTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        newsTitleLabel.numberOfLines = 1
        
        contentView.addSubview(newsTitleLabel)
        newsTitleLabel.setHeight(newsTitleLabel.font.lineHeight)
        newsTitleLabel.pin(to: contentView, [.top: 12, .right: 12])
        newsTitleLabel.pinLeft(to: newsImageView.trailingAnchor, 12)
    }
    
    private func setupDescriptionLabel() {
        newsDescriptionLabel.textColor = .secondaryLabel
        newsDescriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        newsDescriptionLabel.numberOfLines = 0
        
        contentView.addSubview(newsDescriptionLabel)
        newsDescriptionLabel.pinRight(to: contentView, 16)
        newsDescriptionLabel.pinBottom(to: contentView, lessOrEqual: 12)
        newsDescriptionLabel.pinLeft(to: newsImageView.trailingAnchor, 12)
        newsDescriptionLabel.pinTop(to: newsTitleLabel.bottomAnchor, 12)
    }
    
    public func configure(with model: NewsViewModel) {
        newsTitleLabel.text = model.title
        newsDescriptionLabel.text = model.description
        if let data = model.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = model.imageURL {
            model.imageData = newsImageView.download(from: url)
        }
        
    }

}

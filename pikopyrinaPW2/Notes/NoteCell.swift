//
//  NoteCell.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 21.11.2022.
//

import UIKit

final class NoteCell: UITableViewCell {
    static let reuseIdentifier = "NoteCell"
    private var noteLabel = UILabel()
    
    override
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
        noteLabel.font = .systemFont(ofSize: 16, weight: .regular)
        noteLabel.textColor = .secondaryLabel
        noteLabel.numberOfLines = 0
        noteLabel.backgroundColor = .clear
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(noteLabel)
        noteLabel.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
    }
    
    public func configure(_ note: ShortNote) {
        noteLabel.text = note.text
    }
}

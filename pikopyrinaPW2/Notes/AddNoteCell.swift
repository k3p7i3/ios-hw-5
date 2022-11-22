//
//  AddNoteCell.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 22.11.2022.
//

import UIKit

final class AddNoteCell: UITableViewCell, UITextViewDelegate {
    static let reuseIdentifier = "AddNoteCell"
    weak var delegate: AddNoteDelegate?
    
    private var textView = UITextView()
    private let placeholderText: String = "Type your note here..."
    private let placeholderColor: UIColor = .tertiaryLabel
    private let noteTextColor: UIColor = .secondaryLabel
    
    public var addButton = UIButton()
    
    
    override
    init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    override
    func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        textView.delegate = self
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = placeholderColor
        textView.text = placeholderText
        textView.backgroundColor = .clear
        textView.setHeight(140)
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped(_:)),
            for: .touchUpInside
        )
        addButton.isEnabled = false
        addButton.alpha = 0.5
        
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .right: 16, .top: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // if the placeholder is showed then remove it and change color
        if textView.textColor == placeholderColor {
            textView.text = ""
            textView.textColor = noteTextColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // if the text in textView is empty then show placeholder
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = placeholderColor
        }
        
        // disable addButton if there's placeholder and enable otherwise
        addButton.isEnabled = (textView.textColor != placeholderColor)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == placeholderColor || textView.text.isEmpty {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
    }
    
    
    @objc
    func addButtonTapped(_ sender: UIButton) {
        let newNote = ShortNote(text: textView.text)
        textView.text = ""
        textViewDidEndEditing(textView)
        delegate?.newNoteAdded(note: newNote)
    }
}

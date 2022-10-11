//
//  Main.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 11.10.2022.
//

import UIKit


final class WelcomeViewController: UIViewController {
    private let incrementButton = UIButton()
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private var value: Int = 0
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.pinHeight(to: button.widthAnchor)
        return button
    }
    
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(
            ofSize: 16.0,
            weight: .medium
        )
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow()
        
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        
        incrementButton.addTarget(
            self,
            action: #selector(incrementButtonPressed),
            for: .touchUpInside
        )
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view.centerXAnchor)
    }
    
    
    @discardableResult
    private func setupCommentLabel() -> UIView {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        
        view.addSubview(commentView)
        commentView.pinTop(
            to: self.view.safeAreaLayoutGuide.topAnchor
        )
        commentView.pin(
            to: self.view,
            [.left: 24, .right: 24]
        )
        
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        
        commentView.addSubview(commentLabel)
        commentLabel.pin(
            to: commentView,
            [.top: 16, .left: 16, .right: 16, .bottom: 16]
        )
        
        updateCommentLabel()
        
        return commentView
    }
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "📝")
        let newsButton = makeMenuButton(title: "📰")
        
        let buttonsSV = UIStackView(
            arrangedSubviews: [colorsButton, notesButton, newsButton]
        )
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(
            to: self.view,
            [.left: 24, .right: 24]
        )
        buttonsSV.pinBottom(
            to: self.view.safeAreaLayoutGuide.bottomAnchor,
            24
        )
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        
        //setup all needed UI components
        setupIncrementButton()
        setupValueLabel()
        setupCommentLabel()
        setupMenuButtons()
    }
    
    private func getUpdatedComment() -> String {
        // returns the comment depending of the value
        switch value {
        case 0...10:
            return "1 - You only started!!"
        case 11...20:
            return "2 - +15 social credit 🇨🇳🇨🇳🇨🇳"
        case 21...30:
            return "3 - party present you rice 🍚🇨🇳"
        case 31...40:
            return "4 - you're almost there!"
        case 41...50:
            return "🎉🎉🎉🎉🎉🎉🎉🎉"
        case 51...60:
            return "big boyyyy"
        case 61...70:
            return "70 70 70 more more moreeee"
        case 71...80:
            return "go little rock star ⭐️⭐️⭐️⭐️⭐️"
        case 81...90:
            return "+80 social credit "
        case 91...100:
            return "party gives you a cat wife🐈👧🏻🇨🇳🇨🇳🇨🇳"
        default:
            return "bro go touch some grass...🌱"
            
        }
    }
    
    
    private func updateCommentLabel() {
        commentLabel.text = getUpdatedComment()
    }
    
    private func updateUI() {
        // update counter label and comment label
        valueLabel.text = "\(value)"
        updateCommentLabel()
    }
    
    @objc
    private func incrementButtonPressed() {
        value += 1
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        // use animation only if comment is changing
        if commentLabel.text != getUpdatedComment() {
            UIView.transition(
                with: commentLabel,
                duration: 0.5,
                options: .transitionFlipFromTop,
                animations: {
                    self.updateUI()
                }
            )
        } else {
            updateUI()
        }
        
    }

    override func viewDidLoad() {
        setupView()
    }
    
}

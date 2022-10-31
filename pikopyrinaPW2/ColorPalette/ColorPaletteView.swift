//
//  ColorPaletteView.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 28.10.2022.
//

import UIKit

final class ColorPaletteView: UIView {
    // add delegate to pass the value of chosenColor to controller
    weak var delegate: ColorPaletteViewDelegate?
    var sliderDelegates: [ColorSliderViewDelegate] = []
    
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .systemGray6
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateColor(color: UIColor) {
        self.chosenColor = color
        for (index, slider) in sliderDelegates.enumerated() {
            switch index {
            case 0:
                slider.updateSlider(Float(chosenColor.redComponent))
            case 1:
                slider.updateSlider(Float(chosenColor.greenComponent))
            default:
                slider.updateSlider(Float(chosenColor.blueComponent))
            }
        }
        
    }
    
    private func setupView() {
        let redControl = ColorSliderView(colorName: "R", value: Float(chosenColor.redComponent))
        let greenControl = ColorSliderView(colorName: "G", value: Float(chosenColor.greenComponent))
        let blueControl = ColorSliderView(colorName: "B", value: Float(chosenColor.blueComponent))
        
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        
        sliderDelegates = [redControl, greenControl, blueControl]
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        
        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)), for: .touchDragInside)
        }
        
        addSubview(stackView)
        stackView.pin(to: self, [.left: 12, .top: 12, .bottom: 12, .right: 12])
        
    }
    
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag {
        case 0:
            self.chosenColor = UIColor(
                red: CGFloat(slider.value),
                green: chosenColor.greenComponent,
                blue: chosenColor.blueComponent,
                alpha: chosenColor.alphaComponent
            )
        case 1:
            self.chosenColor = UIColor(
                red: chosenColor.redComponent,
                green: CGFloat(slider.value),
                blue: chosenColor.blueComponent,
                alpha: chosenColor.alphaComponent
            )
        default:
            self.chosenColor = UIColor(
                red: chosenColor.redComponent,
                green: chosenColor.greenComponent,
                blue: CGFloat(slider.value),
                alpha: chosenColor.alphaComponent
            )
        }
        delegate?.changeColor(self)
    }
}


extension ColorPaletteView {
    private final class ColorSliderView: UIControl, ColorSliderViewDelegate {
        private let slider = UISlider()
        private let colorLabel = UILabel()
        
        private(set) var value: Float
        
        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)
            
            slider.value = value
            colorLabel.text = colorName
            setupView()
            
            slider.addTarget(self, action: #selector(sliderMoved(_:)), for: .touchDragInside)
        }
        
        func updateSlider(_ newValue: Float) {
            self.value = newValue
            slider.value = self.value
        }
        
        @available(*, unavailable)
        required init?(coder:NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupView() {
            let stackView = UIStackView(arrangedSubviews: [colorLabel, slider])
            stackView.axis = .horizontal
            stackView.spacing = 8
            
            addSubview(stackView)
            stackView.pin(to: self, [.left: 12, .top: 8, .right: 12, .bottom: 8])
        }
                             
        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
}

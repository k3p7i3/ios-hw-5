//
//  Protocols.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 29.10.2022.
//

import UIKit

protocol ColorPaletteViewDelegate: AnyObject {
    // protocol allow to get the color from ColorPaletteView every time slides are moved
    func changeColor(_ slider: ColorPaletteView)
}

protocol ColorSliderViewDelegate: AnyObject {
    func updateSlider(_ newValue: Float)
}

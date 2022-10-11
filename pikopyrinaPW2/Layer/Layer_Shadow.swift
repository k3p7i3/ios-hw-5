//
//  Layout Shadow.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 11.10.2022.
//

import UIKit

extension CALayer {
    func applyShadow() {
        // add shadow
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.6
        shadowOffset = CGSize(width: 0.5, height: 4.0)
        shadowRadius = 6
    }
}

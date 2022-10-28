//
//  UIColorRGBA.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 29.10.2022.
//

import UIKit

extension UIColor {
    func getRGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red = CGFloat(0.0)
        var green = CGFloat(0.0)
        var blue = CGFloat(0.0)
        var alpha = CGFloat(0.0)
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    var redComponent: CGFloat {
        get {
            return getRGBA().red
        }
    }

    
    var greenComponent: CGFloat {
        get {
            return getRGBA().green
        }
    }
    
    var blueComponent: CGFloat {
        get {
            return getRGBA().blue
        }
    }
    
    var alphaComponent: CGFloat {
        get {
            return getRGBA().alpha
        }
    }
}

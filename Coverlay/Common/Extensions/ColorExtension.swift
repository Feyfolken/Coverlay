//
//  ColorExtension.swift
//  Coverlay
//
//  Created by Feyfolken on 30.07.2021.
//

import UIKit

extension UIColor {
    
    static var mainScreenBackgroundColor: UIColor {
        get {
            return UIColor(named: "mainScreenBackgroundColor") ?? .white
        }
    }
    
    static var darkShadowColor: UIColor {
        get {
            return UIColor(named: "darkShadowColor") ?? .white
        }
    }
    
    static var lightShadowColor: UIColor {
        get {
            return UIColor(named: "lightShadowColor") ?? .black
        }
    }
}

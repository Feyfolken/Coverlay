//
//  FontExtension.swift
//  Coverlay
//
//  Created by Feyfolken on 22.10.2021.
//

import UIKit

public extension UIFont {
    
    static func carattereRegularFontWithSize(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Carattere-Regular", size: fontSize)!
    }
    
    static func signikaNegativeBoldFontWithSize(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "SignikaNegative-Bold", size: fontSize)!
    }
    
    static func signikaNegativeRegularFontWithSize(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "SignikaNegative-Regular", size: fontSize)!
    }
}


//
//  FontExtension.swift
//  Coverlay
//
//  Created by Feyfolken on 22.10.2021.
//

import UIKit

public extension UIFont {
    
    static var carattereRegularFont14: UIFont {return .CarattereRegularFontWithSize(fontSize: 14)}
    
    static func CarattereRegularFontWithSize(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Carattere-Regular", size: fontSize)!
    }
}


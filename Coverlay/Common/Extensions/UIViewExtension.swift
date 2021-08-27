//
//  UIViewExtension.swift
//  Coverlay
//
//  Created by Feyfolken on 27.08.2021.
//

import UIKit

extension UIView {
    
    func findFirstSubview(withClassName className: String) -> UIView? {
        for subview in self.subviewsRecursive() {
            if subview.className() == className {
                return subview
            }
        }
        
        return nil
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
}


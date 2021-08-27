//
//  ImageExtension.swift
//  Coverlay
//
//  Created by Feyfolken on 27.08.2021.
//

import UIKit

extension UIImage {
    
    func withAlphaComponent(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

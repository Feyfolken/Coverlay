//
//  NSObjectExtension.swift
//  Coverlay
//
//  Created by Feyfolken on 27.08.2021.
//
import Foundation

extension NSObject {
    
    func className() -> String {
        return String(describing: type(of: self))
    }
}

//
//  Localizable.swift
//  MVP.Ural-FD
//
//  Created by Feyfolken on 12.03.2021.
//  Copyright © 2021 Diasoft. All rights reserved.
//

import Foundation

public protocol Localizable {
    
    var rawValue: String { get }
    var table: String? { get }
    var localized: String { get }
}

extension Localizable {
    
    public var localized: String {
        return Bundle.main.localizedString(forKey: rawValue, value: nil, table: table)
    }
    
    public var table: String? {
        return nil
    }
}

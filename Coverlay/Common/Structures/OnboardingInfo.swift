//
//  OnboardingInfo.swift
//  Coverlay
//
//  Created by Feyfolken on 02.11.2021.
//

import UIKit

public struct OnboardingInfo {
    public private (set) var infoIcon: UIImage?
    public private (set) var infoMessage: String?
    
    public init(infoIcon: UIImage? = nil, infoMessage: String? = nil) {
        self.infoIcon = infoIcon
        self.infoMessage = infoMessage
    }
}

//
//  AboutAppModuleLocalizationConstants.swift
//  Coverlay
//
//  Created by Feyfolken on 27.10.2021.
//

public enum AboutAppModuleLocalizationConstants: String {
    case screenTitleLabelText
    case generalDescriptionText
    case authorshipText
    
    case firstOnboardingInfoMessage
    case secondOnboardingInfoMessage
    case thirdOnboardingInfoMessage
    case fourthOnboardingInfoMessage
    case fifthOnboardingInfoMessage
}

extension AboutAppModuleLocalizationConstants: Localizable {
    
    public var table: String? {
        return "AboutAppModuleLocalization"
    }
}

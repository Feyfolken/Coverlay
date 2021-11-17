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
    
    case cameraCardMessage
    case galleryCardMessage
    case transparencyCardMessage
    case intersectionCardMessage
    case gesturesCardMessage
    case enableTransformationCardMessage
    case saveCardMessage
}

extension AboutAppModuleLocalizationConstants: Localizable {
    
    public var table: String? {
        return "AboutAppModuleLocalization"
    }
}

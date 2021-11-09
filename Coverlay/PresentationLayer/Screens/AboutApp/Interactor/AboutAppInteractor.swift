//
//  AboutAppInteractor.swift
//  Coverlay
//
//  Created by Vadim Krasilnikov on 26/10/2021.
//  Copyright © 2021 Feyfolken. All rights reserved.
//
import UIKit

final class AboutAppInteractor {

    weak var output: AboutAppInteractorOutput!
}

extension AboutAppInteractor: AboutAppInteractorInput {

    func obtainOnboardingInfo() -> [OnboardingInfo] {
        var onboardingInfoList = [OnboardingInfo]()
        
        let cameraCardInfoObject = OnboardingInfo(infoIcon: UIImage(named: "photo-camera"), infoMessage: AboutAppModuleLocalizationConstants.cameraCardMessage.localized)
        let galleryCardInfoObject = OnboardingInfo(infoIcon: UIImage(named: "gallery-card"), infoMessage: AboutAppModuleLocalizationConstants.galleryCardMessage.localized)
        let transparencyCardInfoObject = OnboardingInfo(infoIcon: UIImage(named: "transparency-card"), infoMessage: AboutAppModuleLocalizationConstants.transparencyCardMessage.localized)
        let intersectionCardInfoObject = OnboardingInfo(infoIcon: UIImage(named: "intersect-card"), infoMessage: AboutAppModuleLocalizationConstants.intersectionCardMessage.localized)
        let gesturesCardInfoObject = OnboardingInfo(infoIcon: UIImage(named: "gesture-card"), infoMessage: AboutAppModuleLocalizationConstants.gesturesCardMessage.localized)
        let saveCardInfoObject = OnboardingInfo(infoIcon: UIImage(named: "saveOnDevice-card"), infoMessage: AboutAppModuleLocalizationConstants.saveCardMessage.localized)
        
        onboardingInfoList = [cameraCardInfoObject,
                              galleryCardInfoObject,
                              transparencyCardInfoObject,
                              intersectionCardInfoObject,
                              gesturesCardInfoObject,
                              saveCardInfoObject]
        
        return onboardingInfoList
    }
}


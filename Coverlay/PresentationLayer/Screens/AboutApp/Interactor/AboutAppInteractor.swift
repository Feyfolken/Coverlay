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
        
        let firstOnboardingInfoObject = OnboardingInfo(infoIcon: UIImage(named: "photo-camera"), infoMessage: AboutAppModuleLocalizationConstants.firstOnboardingInfoMessage.localized)
        let secondOnboardingInfoObject = OnboardingInfo(infoIcon: UIImage(named: "gallery-card"), infoMessage: AboutAppModuleLocalizationConstants.secondOnboardingInfoMessage.localized)
        let thirdOnboardingInfoObject = OnboardingInfo(infoIcon: UIImage(named: "transparency-card"), infoMessage: AboutAppModuleLocalizationConstants.thirdOnboardingInfoMessage.localized)
        let fourthOnboardingInfoObject = OnboardingInfo(infoIcon: UIImage(named: "gesture-card"), infoMessage: AboutAppModuleLocalizationConstants.fourthOnboardingInfoMessage.localized)
        let fifthOnboardingInfoObject = OnboardingInfo(infoIcon: UIImage(named: "saveOnDevice-card"), infoMessage: AboutAppModuleLocalizationConstants.fifthOnboardingInfoMessage.localized)
        onboardingInfoList = [firstOnboardingInfoObject,
                              secondOnboardingInfoObject,
                              thirdOnboardingInfoObject,
                              fourthOnboardingInfoObject,
                              fifthOnboardingInfoObject]
        
        return onboardingInfoList
    }
}


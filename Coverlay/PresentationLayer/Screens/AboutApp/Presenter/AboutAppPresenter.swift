//
//  AboutAppPresenter.swift
//  Coverlay
//
//  Created by Vadim Krasilnikov on 26/10/2021.
//  Copyright © 2021 Feyfolken. All rights reserved.
//

final class AboutAppPresenter {
    
    weak var view: AboutAppViewInput!
    var interactor: AboutAppInteractorInput!
    var router: AboutAppRouterInput!
}

extension AboutAppPresenter: AboutAppModuleInput {
    
}

extension AboutAppPresenter: AboutAppViewOutput {
    
    func viewIsReady() {
        let onboardingInfoList = interactor.obtainOnboardingInfo()
        view.setupInitialState(for: onboardingInfoList)
    }
}

extension AboutAppPresenter: AboutAppInteractorOutput {
    
}

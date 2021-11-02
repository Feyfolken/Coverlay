//
//  AboutAppViewInput.swift
//  Coverlay
//
//  Created by Vadim Krasilnikov on 26/10/2021.
//  Copyright © 2021 Feyfolken. All rights reserved.
//

protocol AboutAppViewInput: AnyObject {

    func setupInitialState(for onboardingInfoList: [OnboardingInfo])
}


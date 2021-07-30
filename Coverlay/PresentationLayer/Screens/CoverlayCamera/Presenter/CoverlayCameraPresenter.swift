//
//  CoverlayCameraPresenter.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

import UIKit

final class CoverlayCameraPresenter {
    
    weak var view: CoverlayCameraViewInput!
    var interactor: CoverlayCameraInteractorInput!
    var router: CoverlayCameraRouter!
}

extension CoverlayCameraPresenter: CoverlayCameraViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func cameraDidFinish(with resultImage: UIImage?) {
        router.closeModule()
    }
}

extension CoverlayCameraPresenter: CoverlayCameraInteractorOutput {
    
}

//
//  CoverlayCameraPresenter.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

import UIKit

final class CoverlayCameraContainerPresenter {
    
    weak var view: CoverlayCameraContainerViewInput!
    var interactor: CoverlayCameraContainerInteractorInput!
    var router: CoverlayCameraContainerRouter!
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerModuleInput {
    
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func cameraDidFinish(with resultImage: UIImage?) {
//        router.closeModule()
    }
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerInteractorOutput {
    
}

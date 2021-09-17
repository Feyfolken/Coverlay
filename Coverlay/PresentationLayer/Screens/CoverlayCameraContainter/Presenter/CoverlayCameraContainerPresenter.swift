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
        view.enableOverlayOpacitySlider(false)
//        router.closeModule()
    }
    
    func didSelectImageFromLibrary(_ image: UIImage?) {
        view.displayOverlayImage(image)
        view.enableOverlayOpacitySlider(true)
    }
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerInteractorOutput {
    
}

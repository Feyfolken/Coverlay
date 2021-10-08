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
    
    @objc
    private func image(_ image: UIImage, didFinishSavingWithError err: Error?, contextInfo: UnsafeRawPointer) {
        
    }
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerModuleInput {
    
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func cameraDidFinish(with resultImage: UIImage?) {
        guard let rawImage = resultImage else {
            router.closeModule()
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(rawImage, self, nil, nil)
        view.enableOverlayOpacitySlider(false)
    }
    
    func didSelectImageFromLibrary(_ image: UIImage?) {
        view.displayOverlayImage(image)
        view.enableOverlayOpacitySlider(true)
    }
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerInteractorOutput {
    
}

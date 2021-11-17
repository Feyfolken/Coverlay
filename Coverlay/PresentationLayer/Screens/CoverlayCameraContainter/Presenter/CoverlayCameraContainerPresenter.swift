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
    private var isOverlayTransformationEnabled = true
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
        
        isOverlayTransformationEnabled = true
        view.setImageForEnableImageTransformationButton(UIImage(named: "unlock_small")!.withColor(color: .white))
    }
    
    func didTapEnableImageTransformationButton() {
        isOverlayTransformationEnabled.toggle()
        
        let imageName = isOverlayTransformationEnabled ? "unlock_small" : "lock_small"
        
        view.setImageForEnableImageTransformationButton(UIImage(named: imageName)!.withColor(color: .white))
        view.enableOverlayImageTransformation(isOverlayTransformationEnabled)
    }
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerInteractorOutput {
    
}

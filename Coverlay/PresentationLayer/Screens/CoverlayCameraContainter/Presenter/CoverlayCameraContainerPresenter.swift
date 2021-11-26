//
//  CoverlayCameraPresenter.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

import UIKit

final class CoverlayCameraContainerPresenter {
    
    weak var view: CoverlayCameraContainerViewInput!
    weak var moduleOutput: CoverlayCameraContainerModuleOutput!
    
    var interactor: CoverlayCameraContainerInteractorInput!
    var router: CoverlayCameraContainerRouter!

    private var isOverlayTransformationEnabled = true
    private var currentlyChosenOverlayImage: UIImage!
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerModuleInput {
    
    func configureModule(with moduleOutput: CoverlayCameraContainerModuleOutput) {
        self.moduleOutput = moduleOutput
    }
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
        moduleOutput.didSaveImageToLibrary()
    }
    
    func didSelectImageFromLibrary(_ image: UIImage?) {
        currentlyChosenOverlayImage = image
        
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
    
    func didTapRestoreOverlayImageFrameButton() {
        isOverlayTransformationEnabled = true
        
        view.displayOverlayImage(currentlyChosenOverlayImage)
        view.enableOverlayOpacitySlider(true)
        view.enableOverlayImageTransformation(true)
        view.setImageForEnableImageTransformationButton(UIImage(named: "unlock_small")!.withColor(color: .white))
    }
}

extension CoverlayCameraContainerPresenter: CoverlayCameraContainerInteractorOutput {
    
}

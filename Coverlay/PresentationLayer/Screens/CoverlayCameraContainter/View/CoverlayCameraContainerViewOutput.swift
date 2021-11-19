//
//  CoverlayCameraViewOutput.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//
import UIKit

protocol CoverlayCameraContainerViewOutput {
    
    func viewIsReady()
    func cameraDidFinish(with resultImage: UIImage?)
    func didSelectImageFromLibrary(_ image: UIImage?)
    func didTapEnableImageTransformationButton()
    func didTapRestoreOverlayImageFrameButton()
}

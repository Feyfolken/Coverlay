//
//  CoverlayCameraViewInput.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//
import UIKit

protocol CoverlayCameraContainerViewInput: AnyObject {
    
    func setupInitialState()
    func displayOverlayImage(_ image: UIImage?)
    func enableOverlayOpacitySlider(_ isEnabled: Bool)
}

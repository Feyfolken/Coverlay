//
//  CoverlayCameraViewOutput.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//
import UIKit

protocol CoverlayCameraViewOutput {
    
    func viewIsReady()
    func cameraDidFinish(with resultImage: UIImage?)
}

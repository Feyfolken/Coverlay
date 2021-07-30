//
//  CoverlayCameraViewController.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

import UIKit

final class CoverlayCameraViewController: UIViewController, UINavigationControllerDelegate {
    
    var output: CoverlayCameraViewOutput!

    // MARK: - Life cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        CoverlayCameraModuleAssembly.assemble(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CoverlayCameraModuleAssembly.assemble(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
    
    // MARK: - Private methods
    private func setupAndPresentCamera() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let cameraViewController = UIImagePickerController()
            
            cameraViewController.sourceType = .camera
            cameraViewController.cameraCaptureMode = .photo
            cameraViewController.cameraDevice = .rear
            cameraViewController.allowsEditing = false
            cameraViewController.delegate = self
            
            self.present(cameraViewController, animated: true)
        }
    }
}

extension CoverlayCameraViewController: CoverlayCameraViewInput {
    
    func setupInitialState() {
        setupAndPresentCamera()
    }
}

extension CoverlayCameraViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false)

        let resultImage = info[.originalImage] as? UIImage
        output.cameraDidFinish(with: resultImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false)
        
        output.cameraDidFinish(with: nil)
    }
}

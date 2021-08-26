//
//  CoverlayCameraViewController.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

import UIKit

final class CoverlayCameraContainerViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraContainerView: UIView!
    
    var output: CoverlayCameraContainerViewOutput!
    var imagePickers: UIImagePickerController?
    
    // MARK: - Life cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        CoverlayCameraContainerModuleAssembly.assemble(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CoverlayCameraContainerModuleAssembly.assemble(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
    
    // MARK: - Private methods
    private func addCameraInView() {
        
        imagePickers = UIImagePickerController()
        if UIImagePickerController.isCameraDeviceAvailable( UIImagePickerController.CameraDevice.rear) {
            imagePickers?.delegate = self
            imagePickers?.sourceType = UIImagePickerController.SourceType.camera
            
            addChild(imagePickers!)
            
            cameraContainerView.addSubview((imagePickers?.view)!)
            imagePickers?.view.frame = cameraContainerView.bounds
            imagePickers?.allowsEditing = false
            imagePickers?.showsCameraControls = true
            imagePickers?.view.autoresizingMask = [.flexibleWidth,  .flexibleHeight]
        }
    }
}

//MARK: - CoverlayCameraContainerViewInput
extension CoverlayCameraContainerViewController: CoverlayCameraContainerViewInput {
    
    func setupInitialState() {
        addCameraInView()
    }
}

//MARK: - UIImagePickerControllerDelegate
extension CoverlayCameraContainerViewController: UIImagePickerControllerDelegate {

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

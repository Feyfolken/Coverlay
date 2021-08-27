//
//  CoverlayCameraViewController.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

import UIKit

final class CoverlayCameraContainerViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraContainerView: UIView!
    @IBOutlet weak var photoGalleryButton: UIButton!
    
    private var coverImageView: UIImageView!
    
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
            imagePickers?.allowsEditing = true
            imagePickers?.showsCameraControls = true
            imagePickers?.view.autoresizingMask = [.flexibleWidth,  .flexibleHeight]
            
            
        }
    }
    
    private func setupPhotoGalleryButton() {
        photoGalleryButton.setImage(UIImage(named: "photo-gallery"), for: .normal)
        photoGalleryButton.tintColor = .white
        photoGalleryButton.backgroundColor = .clear
    }
    
    private func createImageView() {
        guard let cameraPreview = imagePickers?.view.findFirstSubview(withClassName: "CAMPreviewView") else { return }
        
        coverImageView = UIImageView(frame: cameraPreview.frame)
        cameraContainerView.addSubview(coverImageView)
    }
    
    //MARK: IBActions
    @IBAction func didTapPhotoGalleryButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
}

//MARK: - CoverlayCameraContainerViewInput
extension CoverlayCameraContainerViewController: CoverlayCameraContainerViewInput {
    
    func setupInitialState() {
        addCameraInView()
        setupPhotoGalleryButton()
    }
}

//MARK: - UIImagePickerControllerDelegate
extension CoverlayCameraContainerViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let resultImage = info[.originalImage] as? UIImage

        if picker.sourceType == .photoLibrary {
            createImageView()
            coverImageView.image = resultImage?.withAlphaComponent(0.5)
        }
        
        picker.dismiss(animated: false)
        output.cameraDidFinish(with: resultImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false)
        
        output.cameraDidFinish(with: nil)
    }
}


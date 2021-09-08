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
    @IBOutlet weak var overlayOpacitySlider: UISlider! {
        didSet {
            overlayOpacitySlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        }
    }
    
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
            imagePickers?.allowsEditing = false
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

        removePreviousOverlay()
        coverImageView = UIImageView(frame: cameraPreview.frame)
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.frame = cameraPreview.frame
        
        cameraContainerView.addSubview(coverImageView)
    }
    
    private func removePreviousOverlay() {
        if coverImageView != nil {
            coverImageView.removeFromSuperview()
            coverImageView = nil
        }
    }
    
    private func setupImageOpacitySlider() {
        overlayOpacitySlider.tintColor = .lightGray
        overlayOpacitySlider.minimumValue = 0.0
        overlayOpacitySlider.maximumValue = 1.0
        
        overlayOpacitySlider.addTarget(self, action: #selector(didChangeSliderValue(sender:)), for: .valueChanged)
        enableOverlayOpacitySlider(false)
    }
    
    private func enableOverlayOpacitySlider(_ enabled: Bool) {
        if enabled {
            overlayOpacitySlider.isUserInteractionEnabled = true
            overlayOpacitySlider.isHidden = false
            
        } else {
            overlayOpacitySlider.isUserInteractionEnabled = false
            overlayOpacitySlider.isHidden = true
        }
        
        overlayOpacitySlider.value = 0.5
    }
    
    private func displayOverlayImage(_ image: UIImage?) {
        guard let rawImage = image else { return }
        
        createImageView()
        coverImageView.image = rawImage
        coverImageView.alpha = 0.5
        coverImageView.isUserInteractionEnabled = true
        
        coverImageView.becomeGestureTransformable(isDraggable: true,
                                                  isRotatable: true,
                                                  isResizable: true,
                                                  gestureRecognizerDelegate: self)
        
        enableOverlayOpacitySlider(true)
    }
    
    @objc
    private func didChangeSliderValue(sender: UISlider) {
        guard coverImageView != nil,
              coverImageView.image != nil else { return }
        
        coverImageView.alpha = CGFloat(sender.value)
    }
    
    //MARK: IBActions
    @IBAction func didTapPhotoGalleryButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false

        present(imagePicker, animated: true)
    }
}

//MARK: - CoverlayCameraContainerViewInput
extension CoverlayCameraContainerViewController: CoverlayCameraContainerViewInput {
    
    func setupInitialState() {
        addCameraInView()
        setupPhotoGalleryButton()
        setupImageOpacitySlider()
    }
}

//MARK: - UIImagePickerControllerDelegate
extension CoverlayCameraContainerViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let resultImage = info[.originalImage] as? UIImage

        switch picker.sourceType {
        case .photoLibrary:
            displayOverlayImage(resultImage)
            
        case .camera:
            enableOverlayOpacitySlider(false)
            output.cameraDidFinish(with: resultImage)
            
        default:
            break
        }
        
        picker.dismiss(animated: false)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false)
        
        output.cameraDidFinish(with: nil)
    }
}

extension CoverlayCameraContainerViewController: UIGestureRecognizerDelegate {
    
}

//
//  CoverlayCameraViewController.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

import UIKit
import SnapKit

final class CoverlayCameraContainerViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraContainerView: UIView!

    private var overlayOpacitySlider: UISlider!
    private var coverImageView: UIImageView!
    private var photoGalleryButton: UIButton!
    private var enableImageTransformationButton: UIButton!
    
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
        guard let superview = imagePickers?.view.findFirstSubview(withClassName: "CAMTopBar") else { return }
        let galleryImage = UIImage(named: "photo-gallery")?.withColor(color: .white)
        photoGalleryButton = UIButton()
        
        photoGalleryButton.setImage(galleryImage, for: .normal)
        photoGalleryButton.tintColor = .white
        photoGalleryButton.backgroundColor = .clear
        photoGalleryButton.addTarget(self,
                                     action: #selector(didTapPhotoGalleryButton(_:)),
                                     for: .touchUpInside)
        
        superview.addSubview(photoGalleryButton)
        
        photoGalleryButton.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.trailing.equalTo(-1)
            maker.height.equalTo(42)
            maker.width.equalTo(44)
        }
    }
    
    private func setupEnableImageTransformationButton() {
        guard enableImageTransformationButton == nil else { return }
        
        enableImageTransformationButton = UIButton()
        enableImageTransformationButton.setImage(UIImage(named:"unlock_small")?.withColor(color: .white), for: .normal)
        enableImageTransformationButton.tintColor = .white
        enableImageTransformationButton.backgroundColor = .clear
        enableImageTransformationButton.contentMode = .scaleAspectFit
        enableImageTransformationButton.addTarget(self,
                                     action: #selector(didTapEnableTransformationButton(_:)),
                                     for: .touchUpInside)
        
        view.addSubview(enableImageTransformationButton)
        
        enableImageTransformationButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(40)
            maker.height.equalTo(30)
            maker.width.equalTo(32)
        }
    }
    
    private func setupImageOpacitySlider() {
        guard overlayOpacitySlider == nil else { return }

        overlayOpacitySlider = UISlider()
        
        overlayOpacitySlider.tintColor = .lightGray
        overlayOpacitySlider.minimumValue = 0.0
        overlayOpacitySlider.maximumValue = 1.0
        overlayOpacitySlider.minimumValueImage = UIImage(named: "transparent")
        overlayOpacitySlider.maximumValueImage = UIImage(named: "opaque")
        overlayOpacitySlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        
        cameraContainerView.addSubview(overlayOpacitySlider)

        overlayOpacitySlider.addTarget(self, action: #selector(didChangeSliderValue(sender:)), for: .valueChanged)
        enableOverlayOpacitySlider(false)
        
        overlayOpacitySlider.snp.makeConstraints { maker in
            maker.centerX.equalTo(view.snp.trailing).offset(-20)
            maker.centerY.equalTo(view.snp.centerY)
            maker.width.equalTo(250)
        }
    }
    
    private func createNewOverlayImageView() {
        guard let cameraPreview = imagePickers?.view.findFirstSubview(withClassName: "CAMPreviewView") else { return }
        //PLImageView
        removePreviousOverlay()
        coverImageView = UIImageView(frame: cameraPreview.frame)
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.frame = cameraPreview.frame
        
        cameraContainerView.insertSubview(coverImageView, belowSubview: overlayOpacitySlider)
    }
    
    private func removePreviousOverlay() {
        if coverImageView != nil {
            coverImageView.removeFromSuperview()
            coverImageView = nil
        }
    }
    
    //MARK: - Actions
    @objc
    private func didChangeSliderValue(sender: UISlider) {
        guard coverImageView != nil,
              coverImageView.image != nil else { return }
        
        coverImageView.alpha = CGFloat(sender.value)
    }
    
    @objc
    func didTapPhotoGalleryButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true)
    }
    
    @objc
    func didTapEnableTransformationButton(_ sender: UIButton) {
        output.didTapEnableImageTransformationButton()
    }
}

//MARK: - CoverlayCameraContainerViewInput
extension CoverlayCameraContainerViewController: CoverlayCameraContainerViewInput {
    
    func setupInitialState() {
        addCameraInView()
        setupImageOpacitySlider()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.setupPhotoGalleryButton()
        }
    }
    
    func displayOverlayImage(_ image: UIImage?) {
        guard let rawImage = image else { return }
        
        createNewOverlayImageView()
        coverImageView.image = rawImage
        coverImageView.alpha = 0.5
        coverImageView.isUserInteractionEnabled = true
        coverImageView.becomeGestureTransformable(gestureRecognizerDelegate: self)
        
        setupEnableImageTransformationButton()
    }
    
    func enableOverlayOpacitySlider(_ isEnabled: Bool) {
        if isEnabled {
            overlayOpacitySlider.isUserInteractionEnabled = true
            overlayOpacitySlider.isHidden = false
            
        } else {
            overlayOpacitySlider.isUserInteractionEnabled = false
            overlayOpacitySlider.isHidden = true
        }
        
        overlayOpacitySlider.value = 0.5
    }
    
    func setImageForEnableImageTransformationButton(_ image: UIImage) {
        enableImageTransformationButton.setImage(image, for: .normal)
    }
    
    func enableOverlayImageTransformation(_ isEnabled: Bool) {
        coverImageView.isUserInteractionEnabled = isEnabled
    }
}

//MARK: - UIImagePickerControllerDelegate
extension CoverlayCameraContainerViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let resultImage = info[.originalImage] as? UIImage
        
        switch picker.sourceType {
        case .photoLibrary:
            output.didSelectImageFromLibrary(resultImage)
            
        case .camera:
            output.cameraDidFinish(with: resultImage)
            
        default:
            break
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        
        output.cameraDidFinish(with: nil)
    }
}

//MARK: - UIGestureRecognizerDelegate
extension CoverlayCameraContainerViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
    -> Bool {
        return true
    }
}

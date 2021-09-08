//
//  ImageExtension.swift
//  Coverlay
//
//  Created by Feyfolken on 27.08.2021.
//

import UIKit

extension UIImage {
    
    func withAlphaComponent(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIImageView {
    
    func becomeGestureTransformable(isDraggable: Bool = true,
                                    isRotatable: Bool = true,
                                    isResizable: Bool = true,
                                    gestureRecognizerDelegate: UIGestureRecognizerDelegate) {
        if isDraggable {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragImageView(sender:)))
            panGestureRecognizer.delegate = gestureRecognizerDelegate
            self.addGestureRecognizer(panGestureRecognizer)
        }
        
        if isRotatable {
            let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotateImageView(sender:)))
            rotationGestureRecognizer.delegate = gestureRecognizerDelegate
            self.addGestureRecognizer(rotationGestureRecognizer)
        }
        
        if isResizable {
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(resizeImageView(sender:)))
            pinchGestureRecognizer.delegate = gestureRecognizerDelegate
            self.addGestureRecognizer(pinchGestureRecognizer)
        }
    }
    
    //MARK: - Drag
    @objc
    private func dragImageView(sender: UIPanGestureRecognizer) {
        // Store current transfrom of UIImageView
        let transform = self.transform
        
        // Initialize imageView.transform
        self.transform = CGAffineTransform.identity
        
        // Move UIImageView
        let point: CGPoint = sender.translation(in: self)
        let movedPoint = CGPoint(x: self.center.x + point.x,
                                 y: self.center.y + point.y)
        self.center = movedPoint
        
        // Revert imageView.transform
        self.transform = transform
        
        // Reset translation
        sender.setTranslation(CGPoint.zero, in: self)
    }
    
    //MARK: - Rotate
    @objc
    private func rotateImageView(sender: UIRotationGestureRecognizer) {
        self.transform = self.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
    //MARK: - Resize
    @objc
    private func resizeImageView(sender: UIPinchGestureRecognizer) {
        print(sender.scale)
        self.transform = self.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
}

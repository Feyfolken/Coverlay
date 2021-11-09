//
//  ImageExtension.swift
//  Coverlay
//
//  Created by Feyfolken on 27.08.2021.
//

import UIKit

//MARK: - UIImage
extension UIImage {
    
    enum Axis {
        case horizontally, vertically
    }
    
    func withAlphaComponent(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func withColor(color: UIColor) -> UIImage {
        var coloredImage = self.withRenderingMode(.alwaysTemplate)
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        color.set()
        coloredImage.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        coloredImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        return coloredImage
    }
    
    func flipped(_ axis: Axis) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: self.size.width/2, y: self.size.height/2)
        
        switch axis {
        case .horizontally:
            context.scaleBy(x: -1.0, y: 1.0)
            
        case .vertically:
            context.scaleBy(x: 1.0, y: -1.0)
        }
        
        context.translateBy(x: -self.size.width/2, y: -self.size.height/2)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

//MARK: - UIImageView
extension UIImageView {
    func becomeGestureTransformable(isDraggable: Bool = true,
                                    isRotatable: Bool = true,
                                    isResizable: Bool = true,
                                    isFlippable: Bool = true,
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
        
        if isFlippable {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flipImageHorizontally(sender:)))
            self.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    //MARK: - Drag action
    @objc
    private func dragImageView(sender: UIPanGestureRecognizer) {
        let initialTransform = self.transform
        self.transform = CGAffineTransform.identity
        
        let point: CGPoint = sender.translation(in: self)
        let movedPoint = CGPoint(x: self.center.x + point.x,
                                 y: self.center.y + point.y)
        self.center = movedPoint
        self.transform = initialTransform
        
        sender.setTranslation(CGPoint.zero, in: self)
    }
    
    //MARK: - Rotate action
    @objc
    private func rotateImageView(sender: UIRotationGestureRecognizer) {
        self.transform = self.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
    //MARK: - Resize action
    @objc
    private func resizeImageView(sender: UIPinchGestureRecognizer) {
        self.transform = self.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
    
    //MARK: - Flip action
    @objc
    private func flipImageHorizontally(sender: UITapGestureRecognizer) {
        self.image = image?.flipped(.horizontally)
    }
}

//
//  NeumorphicCircleButton.swift
//  Coverlay
//
//  Created by Feyfolken on 30.07.2021.
//

import UIKit

protocol NeumorphicCircleButtonDelegate: AnyObject {
    
    func didTapNeumorphicCircleButton()
}

final class NeumorphicCircleButton: UIView {
    
    weak var delegate: NeumorphicCircleButtonDelegate?
    
    private let topLeftShadowOffset = CGSize(width: -5, height: -5)
    private let bottomRightShadowOffset = CGSize(width: 10, height: 10)
    
    private lazy var darkShadow: CALayer = {
        let darkShadow = CALayer()
        
        darkShadow.frame = self.bounds
        darkShadow.backgroundColor = UIColor.mainScreenBackgroundColor.cgColor
        darkShadow.shadowOffset = bottomRightShadowOffset
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 16
        darkShadow.cornerRadius = frame.size.width / 2
        darkShadow.shadowColor = UIColor.darkShadowColor.cgColor
        
        return darkShadow
    }()
    
    private lazy var lightShadow: CALayer = {
        let lightShadow = CALayer()
        
        lightShadow.frame = self.bounds
        lightShadow.backgroundColor = UIColor.mainScreenBackgroundColor.cgColor
        lightShadow.shadowOffset = topLeftShadowOffset
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 16
        lightShadow.cornerRadius = frame.size.width / 2
        lightShadow.shadowColor = UIColor.lightShadowColor.cgColor
        
        return lightShadow
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
        setupPressGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupPressGesture()
    }
    
    //MARK: - Private
    private func setupView() {
        backgroundColor = .mainScreenBackgroundColor
        
        layer.cornerRadius = frame.size.width / 2
        layer.insertSublayer(darkShadow, at: 0)
        layer.insertSublayer(lightShadow, at: 0)
    }
    
    private func setupPressGesture() {
        let pressGesture = UILongPressGestureRecognizer()
        pressGesture.addTarget(self, action: #selector(handleButtonPressGesture(sender:)))
        pressGesture.minimumPressDuration = .zero

        self.addGestureRecognizer(pressGesture)
    }
    
    @objc
    private func handleButtonPressGesture(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            darkShadow.shadowOffset = topLeftShadowOffset
            lightShadow.shadowOffset = bottomRightShadowOffset
            
        } else if sender.state == .ended {
            lightShadow.shadowOffset = topLeftShadowOffset
            darkShadow.shadowOffset = bottomRightShadowOffset
            
            delegate?.didTapNeumorphicCircleButton()
        }
    }
}

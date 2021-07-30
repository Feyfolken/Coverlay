//
//  NeumorphicCircleButton.swift
//  Coverlay
//
//  Created by Feyfolken on 30.07.2021.
//

import UIKit

final class NeumorphicCircleButton: UIButton {
    
    lazy var darkShadow: CALayer = {
        let darkShadow = CALayer()
        darkShadow.shadowOffset = CGSize(width: 10, height: 10)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 15
        darkShadow.cornerRadius = frame.size.width / 2
        
        return darkShadow
    }()
    
    lazy var lightShadow: CALayer = {
        let lightShadow = CALayer()
        lightShadow.shadowOffset = CGSize(width: -5, height: -5)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 15
        lightShadow.cornerRadius = frame.size.width / 2
        
        return lightShadow
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()

//        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        darkShadow.frame = self.bounds
        darkShadow.backgroundColor = UIColor.mainScreenBackgroundColor.cgColor
        darkShadow.shadowColor = UIColor.darkShadowColor.withAlphaComponent(0.5).cgColor
        
        lightShadow.frame = self.bounds
        lightShadow.backgroundColor = UIColor.mainScreenBackgroundColor.cgColor
        lightShadow.shadowColor = UIColor.lightShadowColor.withAlphaComponent(0.5).cgColor
    }
    
    private func setupView() {
        backgroundColor = .red
        
        layer.cornerRadius = frame.size.width / 2
        layer.insertSublayer(darkShadow, at: 0)
        layer.insertSublayer(lightShadow, at: 0)
    }
}

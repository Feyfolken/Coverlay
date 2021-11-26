//
//  OnboardingInfoCell.swift
//  Coverlay
//
//  Created by Feyfolken on 29.10.2021.
//
import UIKit

final class OnboardingInfoCell: UICollectionViewCell {
    
    public var darkShadowColor: CGColor = UIColor.darkShadowColor.cgColor {
        didSet {
            darkShadow.shadowColor = darkShadowColor
        }
    }
    
    public var lightShadowColor: CGColor = UIColor.lightShadowColor.cgColor {
        didSet {
            lightShadow.shadowColor = lightShadowColor
        }
    }
    
    public var infoImageView: UIImageView!
    public var infoMessageTextView: UITextView!
    
    private let topLeftShadowOffset = CGSize(width: -5, height: -5)
    private let bottomRightShadowOffset = CGSize(width: 5, height: 5)
    
    private lazy var darkShadow: CALayer = {
        let darkShadow = CALayer()
        
        darkShadow.frame = self.bounds
        darkShadow.backgroundColor = UIColor.mainScreenBackgroundColor.cgColor
        darkShadow.shadowOffset = bottomRightShadowOffset
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 6
        darkShadow.cornerRadius = 30
        darkShadow.shadowColor = darkShadowColor
        
        return darkShadow
    }()
    
    private lazy var lightShadow: CALayer = {
        let lightShadow = CALayer()
        
        lightShadow.frame = self.bounds
        lightShadow.backgroundColor = UIColor.mainScreenBackgroundColor.cgColor
        lightShadow.shadowOffset = topLeftShadowOffset
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 6
        lightShadow.cornerRadius = 30
        lightShadow.shadowColor = lightShadowColor
        
        return lightShadow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureCell()
    }
    
    private func configureCell() {
        contentView.backgroundColor = .mainScreenBackgroundColor
        contentView.layer.cornerRadius = 30
        contentView.clipsToBounds = true
        
        layer.insertSublayer(darkShadow, at: 0)
        layer.insertSublayer(lightShadow, at: 0)
        
        createInfoImageView()
        createInfoMessageTextView()
    }
    
    private func createInfoImageView() {
        infoImageView = UIImageView(frame: .zero)
        
        contentView.addSubview(infoImageView)

        infoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-25)
            make.height.width.equalTo(55)
        }
    }
    
    private func createInfoMessageTextView() {
        infoMessageTextView = UITextView(frame: .zero)
        infoMessageTextView.textAlignment = .center
        infoMessageTextView.font = .robotoSlabFontWithSize(fontSize: 15)
        infoMessageTextView.isEditable = false
        infoMessageTextView.backgroundColor = .mainScreenBackgroundColor
        infoMessageTextView.textColor = .commonTextColor
        
        contentView.addSubview(infoMessageTextView)
        
        infoMessageTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
            make.top.equalTo(infoImageView.snp.bottom).offset(9)
        }
    }
}

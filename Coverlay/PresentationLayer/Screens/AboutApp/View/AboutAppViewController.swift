//
//  AboutAppViewController.swift
//  Coverlay
//
//  Created by Vadim Krasilnikov on 26/10/2021.
//  Copyright © 2021 Feyfolken. All rights reserved.
//

import UIKit

final class AboutAppViewController: UIViewController {
    
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var generalDescriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var output: AboutAppViewOutput!
    private var onboardingInfoList = [OnboardingInfo]()
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Life cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        AboutAppModuleAssembly.assemble(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        AboutAppModuleAssembly.assemble(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
    
    //MARK: Private methods
    private func setupScreenTitleLabel() {
        screenTitleLabel.font = .signikaNegativeBoldFontWithSize(fontSize: 22)
        screenTitleLabel.text = AboutAppModuleLocalizationConstants.screenTitleLabelText.localized
        screenTitleLabel.textColor = .commonTextColor
    }
    
    private func setupGeneralDescriptionLabel() {
        generalDescriptionLabel.font = .signikaNegativeRegularFontWithSize(fontSize: 16)
        generalDescriptionLabel.text = AboutAppModuleLocalizationConstants.generalDescriptionText.localized
        generalDescriptionLabel.textColor = .commonTextColor
    }
    
    private func setupAuthorLabel() {
        authorLabel.font = .signikaNegativeRegularFontWithSize(fontSize: 10)
        authorLabel.text = AboutAppModuleLocalizationConstants.authorshipText.localized
        authorLabel.textColor = .commonTextColor
    }
    
    private func setupCollectionView() {
        let collectionViewContainer = UIView()
        collectionViewContainer.backgroundColor = .clear
        view.addSubview(collectionViewContainer)
        
        collectionView.backgroundColor = .clear
        collectionView.register(OnboardingInfoCell.self, forCellWithReuseIdentifier: "onboardingInfoCell")
        collectionViewContainer.addSubview(collectionView)
        
        collectionViewContainer.snp.makeConstraints { make in
            make.leading.trailing.equalTo(20)
            make.bottom.equalTo(authorLabel.snp.top).offset(-30)
            make.top.equalTo(generalDescriptionLabel.snp.bottom).offset(25)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().priority(.medium)
            make.bottom.greaterThanOrEqualToSuperview().priority(.medium)
            make.centerY.equalTo(collectionViewContainer.snp.centerY)
            make.height.equalTo(250)
        }
    }
}

//MARK: - AboutAppViewInput
extension AboutAppViewController: AboutAppViewInput {
    
    func setupInitialState(for onboardingInfoList: [OnboardingInfo]) {
        self.onboardingInfoList = onboardingInfoList
        view.backgroundColor = .mainScreenBackgroundColor

        setupScreenTitleLabel()
        setupGeneralDescriptionLabel()
        setupAuthorLabel()
        setupCollectionView()
    }
}

//MARK: - UICollectionViewDelegate
extension AboutAppViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource
extension AboutAppViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingInfoList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let onboardingInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingInfoCell", for: indexPath) as? OnboardingInfoCell {
            onboardingInfoCell.infoImageView.image = onboardingInfoList[indexPath.row].infoIcon
            onboardingInfoCell.infoMessageTextView.text = onboardingInfoList[indexPath.row].infoMessage
            
            return onboardingInfoCell
        }
        
        return UICollectionViewCell()
    }
}

extension AboutAppViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: collectionView.frame.height - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 30)
    }
}

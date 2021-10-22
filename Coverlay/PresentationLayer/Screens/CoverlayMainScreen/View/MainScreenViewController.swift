//
//  MainScreenViewController.swift
//  Coverlay
//
//  Created by Feyfolken on 30.07.2021.
//

import UIKit

final class MainScreenViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var openCameraModuleButton: NeumorphicCircleButton!
    private var openAboutAppModuleButton: NeumorphicCircleButton!

    var output: MainScreenViewOutput!

    // MARK: - Life cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MainScreenModuleAssembly.assemble(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MainScreenModuleAssembly.assemble(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
    
    // MARK: - Private
    private func createOpenCameraModuleButton() {
        openCameraModuleButton.setButtonImage(UIImage(named: "photo-camera")!)
        openCameraModuleButton.delegate = self
    }
    
    private func createOpenAboutAppModuleButton() {
        openAboutAppModuleButton = NeumorphicCircleButton(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        
        view.addSubview(openAboutAppModuleButton)
        openAboutAppModuleButton.setButtonImage(UIImage(named: "info")!)

        openAboutAppModuleButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(-60)
            maker.height.width.equalTo(75)
        }
        
        openAboutAppModuleButton.delegate = self
    }
}

// MARK: - MainScreenViewInput
extension MainScreenViewController: MainScreenViewInput {
    
    func setupInitialState() {
        title = "Coverlay"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Carattere-Regular", size: 28)!]
        
        navigationController?.navigationBar.barTintColor = .mainScreenBackgroundColor
        view.backgroundColor = .mainScreenBackgroundColor

        createOpenCameraModuleButton()
        createOpenAboutAppModuleButton()
    }
}

// MARK: - NeumorphicCircleButtonDelegate
extension MainScreenViewController: NeumorphicCircleButtonDelegate {
    
    func didTapNeumorphicCircleButton(_ button: NeumorphicCircleButton) {
        output.didTapOpenCameraModuleButton()
    }
}

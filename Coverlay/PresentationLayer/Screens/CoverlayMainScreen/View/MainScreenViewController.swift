//
//  MainScreenViewController.swift
//  Coverlay
//
//  Created by Feyfolken on 30.07.2021.
//

import UIKit

final class MainScreenViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var openCameraModuleButton: NeumorphicCircleButton!
    //    let openCameraModuleButton: NeumorphicCircleButton = {
//        let openCameraModuleButton = NeumorphicCircleButton()
//        openCameraModuleButton.addTarget(self, action: #selector(didTapOpenCameraModuleButton(_:)), for: .touchUpInside)
//
//        return openCameraModuleButton
//    }()
    
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
//        openCameraModuleButton.setImage(UIImage(systemName: "camera"), for: .normal)
    }
    
    
    @IBAction func didTapOpenCameraModuleButton(_ sender: Any) {
        output.didTapOpenCameraModuleButton()
    }
}

// MARK: -
extension MainScreenViewController: MainScreenViewInput {
    
    func setupInitialState() {
        title = "Coverlay"
        
        navigationController?.navigationBar.barTintColor = .mainScreenBackgroundColor
        view.backgroundColor = .mainScreenBackgroundColor
        
        createOpenCameraModuleButton()
    }
}

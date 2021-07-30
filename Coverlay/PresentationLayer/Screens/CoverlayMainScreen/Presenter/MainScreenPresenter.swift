//
//  MainScreenPresenter.swift
//  Coverlay
//
//  Created by Feyfolken on 30.07.2021.
//

final class MainScreenPresenter {
    
    weak var view: MainScreenViewInput!
    var interactor: MainScreenInteractorInput!
    var router: MainScreenRouter!
}

extension MainScreenPresenter: MainScreenViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func didTapOpenCameraModuleButton() {
        router.openCameraModule()
    }
}

extension MainScreenPresenter: MainScreenInteractorOutput {
    
}

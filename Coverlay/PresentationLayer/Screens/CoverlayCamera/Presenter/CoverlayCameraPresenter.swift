//
//  CoverlayCameraPresenter.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

final class CoverlayCameraPresenter {
    
    weak var view: CoverlayCameraViewInput!
    var interactor: CoverlayCameraInteractorInput!
    var router: CoverlayCameraRouter!
}

extension CoverlayCameraPresenter: CoverlayCameraViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
}

extension CoverlayCameraPresenter: CoverlayCameraInteractorOutput {
    
}

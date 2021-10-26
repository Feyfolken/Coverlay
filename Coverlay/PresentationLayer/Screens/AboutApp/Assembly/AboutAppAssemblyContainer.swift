//
//  AboutAppAssemblyContainer.swift
//  Coverlay
//
//  Created by Vadim Krasilnikov on 26/10/2021.
//  Copyright © 2021 Feyfolken. All rights reserved.
//


final class AboutAppModuleAssembly {
    
    static func assemble(with viewController: AboutAppViewController) {
        let presenter = AboutAppPresenter() 
        let interactor = AboutAppInteractor()
        let router = AboutAppRouter()
        
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = router
        
        interactor.output = presenter
        viewController.output = presenter
        router.transitionHandler = viewController
    }
}

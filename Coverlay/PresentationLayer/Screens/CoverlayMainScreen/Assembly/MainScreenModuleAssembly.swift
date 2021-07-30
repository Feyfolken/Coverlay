//
//  MainScreenModuleAssembly.swift
//  Coverlay
//
//  Created by Feyfolken on 30.07.2021.
//

final class MainScreenModuleAssembly {
    
    static func assemble(with viewController: MainScreenViewController) {
        let presenter = MainScreenPresenter()
        let interactor = MainScreenInteractor()
        let router = MainScreenRouterImplementation()
        
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = router
        
        interactor.output = presenter
        viewController.output = presenter
        router.transitionHandler = viewController
    }
}

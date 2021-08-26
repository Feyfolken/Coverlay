//
//  CoverlayCameraModuleAssembly.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

final class CoverlayCameraContainerModuleAssembly {
    
    static func assemble(with viewController: CoverlayCameraContainerViewController) {
        let presenter = CoverlayCameraContainerPresenter()
        let interactor = CoverlayCameraContainerInteractor()
        let router = CoverlayCameraContainerRouterImplementation()
        
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = router
        
        interactor.output = presenter
        viewController.output = presenter
        router.transitionHandler = viewController
    }
}

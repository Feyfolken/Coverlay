//
//  CoverlayCameraModuleAssembly.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

final class CoverlayCameraModuleAssembly {
    
    static func assemble(with viewController: CoverlayCameraViewController) {
        let presenter = CoverlayCameraPresenter()
        let interactor = CoverlayCameraInteractor()
        let router = CoverlayCameraRouterImplementation()
        
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = router
        
        interactor.output = presenter
        viewController.output = presenter
        router.transitionHandler = viewController
    }
}

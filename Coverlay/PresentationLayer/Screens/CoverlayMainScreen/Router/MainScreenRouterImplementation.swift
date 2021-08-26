//
//  MainScreenRouterImplementation.swift
//  Coverlay
//
//  Created by Feyfolken on 30.07.2021.
//

import LiteRoute

final class MainScreenRouterImplementation {
    
    weak var transitionHandler: TransitionHandler!
}

extension MainScreenRouterImplementation: MainScreenRouter {
    
    func openCameraModule() {
        try! transitionHandler.forSegue(identifier: MainModuleStoryboardConstants.mainScreenModuleToContainerModule,
                                        to: CoverlayCameraContainerModuleInput.self).then { moduleInput in
                                            return nil
        }
    }
}

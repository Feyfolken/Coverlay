//
//  CoverlayCameraRouterImplementation.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

import LiteRoute

final class CoverlayCameraContainerRouterImplementation {
    
    weak var transitionHandler: TransitionHandler!
}

extension CoverlayCameraContainerRouterImplementation: CoverlayCameraContainerRouter {
    
    func closeModule() {
       try! transitionHandler
        .closeCurrentModule()
        .perform()
    }
}

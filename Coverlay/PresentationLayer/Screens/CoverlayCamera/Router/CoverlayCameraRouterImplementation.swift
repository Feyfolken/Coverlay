//
//  CoverlayCameraRouterImplementation.swift
//  Coverlay
//
//  Created by Feyfolken on 23.07.2021.
//

import LiteRoute

final class CoverlayCameraRouterImplementation {
    
    weak var transitionHandler: TransitionHandler!
}

extension CoverlayCameraRouterImplementation: CoverlayCameraRouter {
    
    func closeModule() {
       try! transitionHandler
        .closeCurrentModule()
        .perform()
    }
}

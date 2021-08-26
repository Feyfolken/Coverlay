//
//  ContainerViewEmbedSegue.swift
//  Coverlay
//
//  Created by Feyfolken on 25.08.2021.
//

import UIKit
public class UIContainerView: UIView {}

public class ContainerViewEmbedSegue: UIStoryboardSegue {
    
    override public func perform() {
        let parentView = source.view
        let containerView = parentView?.subviews.first(where: { (view) -> Bool in
            return view is UIContainerView
        })
        
        if let rawContainerView = containerView {
            source.addChild(destination)
            destination.view.frame = rawContainerView.bounds
            rawContainerView.addSubview(destination.view)
        }
    }
}

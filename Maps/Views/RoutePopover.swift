//
//  RoutePopover.swift
//  Maps
//
//  Created by Mohammad Azam on 1/10/22.
//

import Foundation
import AppKit

class RoutePopover: NSPopover {
    
    init(controller: RouteContentViewController) {
        super.init()
        self.contentViewController = controller
        self.contentSize = controller.view.frame.size
        self.behavior = .transient
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

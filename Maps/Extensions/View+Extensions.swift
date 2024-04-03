//
//  View+Extensions.swift
//  Maps
//
//  Created by Mohammad Azam on 1/11/22.
//

import Foundation
import AppKit
import SwiftUI

extension View {
    
    @discardableResult 
    func openInWindow(title: String, sender: Any?) -> NSWindow {
        let controller = NSHostingController(rootView: self)
        let window = NSWindow(contentViewController: controller)
        window.contentViewController = controller
        window.title = title
        window.makeKeyAndOrderFront(sender)
        return window 
    }
    
}

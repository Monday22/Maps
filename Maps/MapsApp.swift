//
//  MapsApp.swift
//  Maps
//
//  Created by Mohammad Azam on 12/24/21.
//

import SwiftUI

@main
struct MapsApp: App {
    var body: some Scene {
        WindowGroup {
            
            let appState = AppState()
            
            HomeScreen()
                .frame(minWidth: 1280, minHeight: 720)
                .environmentObject(appState)
        }.commands {
            CommandGroup(after: .appInfo) {
                Button("Preferences") {
                    PreferencesScreen()
                        .openInWindow(title: "Preferences", sender: self)
                }
            }
        }
    }
}

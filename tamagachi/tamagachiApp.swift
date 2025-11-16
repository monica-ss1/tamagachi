//
//  Tomagatchi_But_BetterApp.swift
//  Tomagatchi But Better
//
//  Created by csuftitan on 10/22/25.
//

import SwiftUI
import SwiftData

@main
struct Tomagatchi_But_BetterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MenuView()
        }
        .modelContainer(sharedModelContainer)
    }
}

//
//  GuitarMemoApp.swift
//  GuitarMemo
//
//  Created by Hugues Stéphano TELOLAHY on 28/09/2025.
//

import SwiftUI
import SwiftData

@main
struct GuitarMemoApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: Song.self)
        } catch {
            fatalError("Impossible de créer le ModelContainer: \(error)")
        }
        SongSeeder.seedIfNeeded(context: container.mainContext)
    }

    var body: some Scene {
        WindowGroup {
            SongsView()
        }
        .modelContainer(container)
    }
}

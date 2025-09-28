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
    var body: some Scene {
        WindowGroup {
            SongsView()
        }
        .modelContainer(for: Song.self)
    }
}

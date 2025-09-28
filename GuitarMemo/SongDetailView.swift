//
//  SongDetailView.swift
//  GuitarMemo
//
//  Created by Hugues Stéphano TELOLAHY on 28/09/2025.
//

import SwiftUI

struct SongDetailView: View {
    var song: Song

    var body: some View {
        ScrollView {
            Text(song.tablature)
                .padding()
                .font(.system(.body, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(song.title)
    }
}

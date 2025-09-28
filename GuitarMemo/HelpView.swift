//
//  HelpView.swift
//  GuitarMemo
//
//  Created by Hugues Stéphano TELOLAHY on 28/09/2025.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) private var dismiss

    let chordsUrl = "https://m.media-amazon.com/images/I/815eY5SLoQL._UF1000,1000_QL80_.jpg"

    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: URL(string: chordsUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                } placeholder: {
                    ProgressView("Chargement...")
                }

                Spacer()
            }
            .navigationTitle("Accords")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") {
                        dismiss()
                    }
                }
            }
        }
    }
}

//
//  SongAddView.swift
//  GuitarMemo
//
//  Created by Hugues Stéphano TELOLAHY on 28/09/2025.
//

import SwiftUI
import SwiftData

struct SongAddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context

    @State private var title: String = ""
    @State private var tablature: String = ""
    @State private var imageUrl: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Infos")) {
                    TextField("Titre", text: $title)
                    TextField("URL image", text: $imageUrl)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

                Section(header: Text("Tablature")) {
                    TextEditor(text: $tablature)
                        .frame(height: 200)
                }
            }
            .navigationTitle("Nouvelle chanson")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ajouter") {
                        let song = Song(title: title, tablature: tablature, imageUrl: imageUrl)
                        context.insert(song)
                        try? context.save()
                        dismiss()
                    }
                    .disabled(title.isEmpty || tablature.isEmpty || imageUrl.isEmpty)
                }
            }
        }
    }
}

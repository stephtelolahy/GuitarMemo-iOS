//
//  ContentView.swift
//  GuitarMemo
//
//  Created by Hugues Stéphano TELOLAHY on 28/09/2025.
//

import SwiftUI
import SwiftData

struct SongsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Song.title) private var songs: [Song]
    @State private var searchText = ""
    @State private var showingAddSong = false
    @State private var showingHelp = false

    var filteredSongs: [Song] {
        if searchText.isEmpty {
            return songs
        } else {
            return songs.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.tablature.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(filteredSongs) { song in
                    NavigationLink(destination: SongDetailView(song: song)) {
                        HStack {
                            AsyncImage(url: URL(string: song.imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)

                            Text(song.title)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteSongs)
            }
            .navigationTitle("Chansons")
            .toolbar {
                // Liquid Glass: full search field pinned in the bottom toolbar.
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        showingAddSong = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button {
                        showingHelp = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    ShareLink(
                        item: exportSongs()!,
                        preview: SharePreview("Export to JSON!", icon: Image("file"))
                    )
                }
            }
            .sheet(isPresented: $showingAddSong) {
                SongAddView()
            }
            .sheet(isPresented: $showingHelp) {
                HelpView()
            }
        } detail: {
            Text("Select an item")
        }
        .searchable(text: $searchText, prompt: "Rechercher une chanson")
        .searchToolbarBehavior(.automatic)
    }

    private func deleteSongs(at offsets: IndexSet) {
        for index in offsets {
            context.delete(filteredSongs[index])
        }
        try? context.save()
    }

    private func exportSongs() -> URL? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let data = try encoder.encode(songs)

            let tempURL = FileManager.default.temporaryDirectory
                .appendingPathComponent("songs.json")

            try data.write(to: tempURL, options: .atomic)
            return tempURL
        } catch {
            print("Erreur export JSON:", error)
            return nil
        }
    }
}

#Preview {
    SongsView()
        .modelContainer(for: Song.self, inMemory: true)
}

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
    @State private var showingAddSong = false
    @State private var showingHelp = false
    @State private var searchText = ""

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
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Rechercher une chanson")
            .toolbar {
                Button {
                    showingAddSong = true
                } label: {
                    Image(systemName: "plus")
                }
                Button {
                    showingHelp = true
                } label: {
                    Image(systemName: "questionmark.circle")
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
    }

    private func deleteSongs(at offsets: IndexSet) {
        for index in offsets {
            context.delete(filteredSongs[index])
        }
        try? context.save()
    }
}

#Preview {
    SongsView()
        .modelContainer(for: Song.self, inMemory: true)
}

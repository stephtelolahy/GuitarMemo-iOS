//
//  SongSeeder.swift
//  GuitarMemo
//

import Foundation
import SwiftData

/// Inserts the songs bundled in `Songs/*.txt` into the store.
enum SongSeeder {
    /// Titles already seeded once, so songs the user deletes are not re-added.
    static let seededTitlesKey = "seededSongTitles"

    struct BundledSong: Equatable {
        let title: String
        let tablature: String
        let imageUrl: String
    }

    /// "Wild world - Cat Stevens.txt" -> "Wild world - Cat Stevens"
    static func title(forFileName fileName: String) -> String {
        (fileName as NSString).deletingPathExtension
    }

    /// Parses a song file. An optional first line `image: <url>` (followed by a blank line)
    /// gives the cover image; the rest is the tablature.
    static func parse(title: String, contents: String) -> BundledSong {
        let prefix = "image:"
        guard contents.hasPrefix(prefix) else {
            return BundledSong(title: title, tablature: contents, imageUrl: "")
        }
        let parts = contents.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: false)
        let imageUrl = parts[0].dropFirst(prefix.count).trimmingCharacters(in: .whitespaces)
        var tablature = parts.count > 1 ? String(parts[1]) : ""
        if tablature.hasPrefix("\n") { tablature.removeFirst() }
        return BundledSong(title: title, tablature: tablature, imageUrl: imageUrl)
    }

    static func bundledSongs(in bundle: Bundle = .main) -> [BundledSong] {
        // Synchronized folders copy resources flat into the bundle root; also accept a "Songs" folder.
        let nested = bundle.urls(forResourcesWithExtension: "txt", subdirectory: "Songs") ?? []
        let urls = nested.isEmpty ? (bundle.urls(forResourcesWithExtension: "txt", subdirectory: nil) ?? []) : nested
        return urls
            .compactMap { url in
                guard let contents = try? String(contentsOf: url, encoding: .utf8) else { return nil }
                return parse(title: title(forFileName: url.lastPathComponent), contents: contents)
            }
            .sorted { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
    }

    /// Adds bundled songs that were never seeded and are not already in the store,
    /// and fills in the image of bundled songs stored without one.
    static func seedIfNeeded(context: ModelContext,
                             defaults: UserDefaults = .standard,
                             bundle: Bundle = .main) {
        let bundled = bundledSongs(in: bundle)
        var seededTitles = Set(defaults.stringArray(forKey: seededTitlesKey) ?? [])
        let stored = (try? context.fetch(FetchDescriptor<Song>())) ?? []
        let storedByTitle = Dictionary(stored.map { ($0.title, $0) }, uniquingKeysWith: { first, _ in first })

        for song in bundled {
            if let existing = storedByTitle[song.title] {
                if existing.imageUrl.isEmpty && !song.imageUrl.isEmpty {
                    existing.imageUrl = song.imageUrl
                }
            } else if !seededTitles.contains(song.title) {
                context.insert(Song(title: song.title, tablature: song.tablature, imageUrl: song.imageUrl))
            }
            seededTitles.insert(song.title)
        }

        do {
            try context.save()
            defaults.set(seededTitles.sorted(), forKey: seededTitlesKey)
        } catch {
            print("Erreur import chansons:", error)
        }
    }
}

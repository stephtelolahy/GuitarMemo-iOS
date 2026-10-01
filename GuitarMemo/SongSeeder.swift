//
//  SongSeeder.swift
//  GuitarMemo
//

import Foundation
import SwiftData

/// Inserts the songs bundled in `Songs/*.txt` into the store on first launch.
enum SongSeeder {
    /// Bump when adding bundled songs so existing installs receive them.
    static let currentVersion = 1
    static let versionKey = "seededSongsVersion"

    struct BundledSong: Equatable {
        let title: String
        let tablature: String
    }

    /// "Wild world - Cat Stevens.txt" -> "Wild world - Cat Stevens"
    static func title(forFileName fileName: String) -> String {
        (fileName as NSString).deletingPathExtension
    }

    static func bundledSongs(in bundle: Bundle = .main) -> [BundledSong] {
        // Synchronized folders copy resources flat into the bundle root; also accept a "Songs" folder.
        let nested = bundle.urls(forResourcesWithExtension: "txt", subdirectory: "Songs") ?? []
        let urls = nested.isEmpty ? (bundle.urls(forResourcesWithExtension: "txt", subdirectory: nil) ?? []) : nested
        return urls
            .compactMap { url in
                guard let tablature = try? String(contentsOf: url, encoding: .utf8) else { return nil }
                return BundledSong(title: title(forFileName: url.lastPathComponent), tablature: tablature)
            }
            .sorted { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
    }

    /// Seeds once per `currentVersion`, so songs the user deletes are not re-added,
    /// and skips titles already in the store so nothing is duplicated.
    static func seedIfNeeded(context: ModelContext,
                             defaults: UserDefaults = .standard,
                             bundle: Bundle = .main) {
        guard defaults.integer(forKey: versionKey) < currentVersion else { return }

        let existingTitles = Set(((try? context.fetch(FetchDescriptor<Song>())) ?? []).map(\.title))
        for song in bundledSongs(in: bundle) where !existingTitles.contains(song.title) {
            context.insert(Song(title: song.title, tablature: song.tablature, imageUrl: ""))
        }

        do {
            try context.save()
            defaults.set(currentVersion, forKey: versionKey)
        } catch {
            print("Erreur import chansons:", error)
        }
    }
}

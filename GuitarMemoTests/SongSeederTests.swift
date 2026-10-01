//
//  SongSeederTests.swift
//  GuitarMemoTests
//

import Foundation
import SwiftData
import Testing
@testable import GuitarMemo

// Song.swift is also compiled into this target, so use the app's type explicitly.
private typealias AppSong = GuitarMemo.Song

@MainActor
struct SongSeederTests {
    private let appBundle = Bundle(for: AppSong.self)

    private func makeContext() throws -> ModelContext {
        let container = try ModelContainer(for: AppSong.self,
                                           configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        return ModelContext(container)
    }

    private func makeDefaults() -> UserDefaults {
        UserDefaults(suiteName: "SongSeederTests-\(UUID().uuidString)")!
    }

    private func titles(in context: ModelContext) throws -> [String] {
        try context.fetch(FetchDescriptor<AppSong>()).map(\.title)
    }

    @Test func titleDropsExtension() {
        #expect(SongSeeder.title(forFileName: "Wild world - Cat Stevens.txt") == "Wild world - Cat Stevens")
        #expect(SongSeeder.title(forFileName: "I don't wanna miss a thing - Aerosmith.txt")
                == "I don't wanna miss a thing - Aerosmith")
    }

    @Test func bundleContainsAllSongs() {
        let songs = SongSeeder.bundledSongs(in: appBundle)
        #expect(songs.count == 24)
        #expect(songs.allSatisfy { !$0.tablature.isEmpty })
        #expect(songs.contains { $0.title == "Hélène - Roch Voisine" })
    }

    @Test func legacyEncodedSongsAreReadable() throws {
        let songs = SongSeeder.bundledSongs(in: appBundle)
        let wildWorld = try #require(songs.first { $0.title == "Wild world - Cat Stevens" })
        #expect(wildWorld.tablature.contains("(G6 – Em)"))
        #expect(!wildWorld.tablature.contains("\r"))
    }

    @Test func seedsAllSongsOnce() throws {
        let context = try makeContext()
        let defaults = makeDefaults()

        SongSeeder.seedIfNeeded(context: context, defaults: defaults, bundle: appBundle)
        #expect(try titles(in: context).count == 24)

        SongSeeder.seedIfNeeded(context: context, defaults: defaults, bundle: appBundle)
        #expect(try titles(in: context).count == 24)
    }

    @Test func doesNotDuplicateExistingTitles() throws {
        let context = try makeContext()
        context.insert(AppSong(title: "Zombie - Cranberries", tablature: "custom", imageUrl: ""))
        try context.save()

        SongSeeder.seedIfNeeded(context: context, defaults: makeDefaults(), bundle: appBundle)

        let all = try titles(in: context)
        #expect(all.count == 24)
        #expect(all.filter { $0 == "Zombie - Cranberries" }.count == 1)
    }

    @Test func everyBundledSongHasAnImage() {
        let songs = SongSeeder.bundledSongs(in: appBundle)
        #expect(Set(songs.map(\.title)) == Set(SongImages.byTitle.keys))
        #expect(songs.allSatisfy { URL(string: $0.imageUrl)?.scheme == "https" })
    }

    @Test func seededSongsHaveImages() throws {
        let context = try makeContext()
        SongSeeder.seedIfNeeded(context: context, defaults: makeDefaults(), bundle: appBundle)
        #expect(try context.fetch(FetchDescriptor<AppSong>()).allSatisfy { !$0.imageUrl.isEmpty })
    }

    @Test func backfillsMissingImageWithoutTouchingCustomOnes() throws {
        let context = try makeContext()
        context.insert(AppSong(title: "Numb - Linkin Park", tablature: "old", imageUrl: ""))
        context.insert(AppSong(title: "Zombie - Cranberries", tablature: "mine", imageUrl: "https://example.com/z.jpg"))
        try context.save()

        SongSeeder.seedIfNeeded(context: context, defaults: makeDefaults(), bundle: appBundle)

        let songs = try context.fetch(FetchDescriptor<AppSong>())
        let numb = try #require(songs.first { $0.title == "Numb - Linkin Park" })
        let zombie = try #require(songs.first { $0.title == "Zombie - Cranberries" })
        #expect(numb.imageUrl == SongImages.byTitle["Numb - Linkin Park"])
        #expect(numb.tablature == "old")
        #expect(zombie.imageUrl == "https://example.com/z.jpg")
    }

    @Test func deletedSongsAreNotReseeded() throws {
        let context = try makeContext()
        let defaults = makeDefaults()
        SongSeeder.seedIfNeeded(context: context, defaults: defaults, bundle: appBundle)

        let first = try #require(try context.fetch(FetchDescriptor<AppSong>()).first)
        context.delete(first)
        try context.save()

        SongSeeder.seedIfNeeded(context: context, defaults: defaults, bundle: appBundle)
        #expect(try titles(in: context).count == 23)
    }
}

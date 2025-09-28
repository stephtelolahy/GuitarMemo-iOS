//
//  Song.swift
//  GuitarMemo
//
//  Created by Hugues Stéphano TELOLAHY on 28/09/2025.
//

import Foundation
import SwiftData

@Model
class Song: Identifiable, Codable {
    @Attribute(.unique) var id: UUID
    var title: String
    var tablature: String
    var imageUrl: String

    init(id: UUID = UUID(), title: String, tablature: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.tablature = tablature
        self.imageUrl = imageUrl
    }

    // MARK: - Codable conformance
    enum CodingKeys: String, CodingKey {
        case id, title, tablature, imageUrl
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        tablature = try container.decode(String.self, forKey: .tablature)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(tablature, forKey: .tablature)
        try container.encode(imageUrl, forKey: .imageUrl)
    }
}

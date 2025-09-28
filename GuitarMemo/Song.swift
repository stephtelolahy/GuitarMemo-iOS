//
//  Song.swift
//  GuitarMemo
//
//  Created by Hugues Stéphano TELOLAHY on 28/09/2025.
//

import Foundation
import SwiftData

@Model
class Song {
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
}

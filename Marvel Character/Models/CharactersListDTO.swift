//
//  CharacterModel.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 19/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

// MARK: - CharactersList
struct CharactersListDTO: Codable {
    let code: Int?
    let status: String?
    let data: DataClass?
}

struct DataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [CharacterDTO]?
}

struct CharacterDTO: Codable {
    let id: Int?
    let name: String?
    let thumbnail: Thumbnail?
    let comics: Comics?
    let stories: Stories?
}

struct Comics: Codable {
    let items: [ComicsItem]?
}

struct ComicsItem: Codable {
    let name: String?
}

struct Stories: Codable {
    let items: [StoriesItem]?
}

struct StoriesItem: Codable {
    let name: String?
}

struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

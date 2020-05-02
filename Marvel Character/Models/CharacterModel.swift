//
//  CharacterModel.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 19/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

// MARK: - CharactersList
struct CharactersList: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass?
    
    struct DataClass: Codable {
        let offset, limit, total, count: Int?
        let results: [DataRawValue]?
    }

    // MARK: - Result
    struct DataRawValue: Codable {
        let id: Int?
        let name, resultDescription: String?
        let modified: String?
        let thumbnail: Thumbnail?
        let resourceURI: String?
        let comics, series: Comics?
        let stories: Stories?
        let events: Comics?
        let urls: [URLElement]?

        enum CodingKeys: String, CodingKey {
            case id, name
            case resultDescription = "description"
            case modified, thumbnail, resourceURI, comics, series, stories, events, urls
        }
    }

    // MARK: - Comics
    struct Comics: Codable {
        let available: Int?
        let collectionURI: String?
        let items: [ComicsItem]?
        let returned: Int?
    }

    // MARK: - ComicsItem
    struct ComicsItem: Codable {
        let resourceURI: String?
        let name: String?
    }

    // MARK: - Stories
    struct Stories: Codable {
        let available: Int?
        let collectionURI: String?
        let items: [StoriesItem]?
        let returned: Int?
    }

    // MARK: - StoriesItem
    struct StoriesItem: Codable {
        let resourceURI: String?
        let name: String?
        let type: String?
    }

    enum TypeEnum: String, Codable {
        case cover = "cover"
        case interiorStory = "interiorStory"
    }

    // MARK: - Thumbnail
    struct Thumbnail: Codable {
        let path: String?
        let thumbnailExtension: String?

        enum CodingKeys: String, CodingKey {
            case path
            case thumbnailExtension = "extension"
        }
    }

    // MARK: - URLElement
    struct URLElement: Codable {
        let type: String?
        let url: String?
    }
}

//
//  CharacteresMock.swift
//  Marvel CharacterTests
//
//  Created by Gonzalo Vizeu on 8/3/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import Foundation
@testable import Marvel_Character

struct CharacteresMock {
    
    static func getFullCharacteres() -> Characters {
        return Characters(characters: [Character(id: 1,
                                                 name: "test 1",
                                                 imagePath: "",
                                                 imageExtension: "",
                                                 stories: [Storie(title: "Story 1"),
                                                           Storie(title: "Story 2"),
                                                           Storie(title: "Story 3")],
                                                 comics: [Comic(title: "Comic 1"),
                                                          Comic(title: "Comic 2"),
                                                          Comic(title: "Comic 3")]),
                                        Character(id: 2,
                                                 name: "test 2",
                                                 imagePath: "",
                                                 imageExtension: "",
                                                 stories: [Storie(title: "Story 1"),
                                                           Storie(title: "Story 2"),
                                                           Storie(title: "Story 3")],
                                                 comics: [Comic(title: "Comic 1"),
                                                          Comic(title: "Comic 2"),
                                                          Comic(title: "Comic 3")]),
                                        Character(id: 3,
                                                  name: "test 3",
                                                  imagePath: "",
                                                  imageExtension: "",
                                                  stories: [Storie(title: "Story 1"),
                                                            Storie(title: "Story 2"),
                                                            Storie(title: "Story 3")],
                                                  comics: [Comic(title: "Comic 1"),
                                                           Comic(title: "Comic 2"),
                                                           Comic(title: "Comic 3")])],
                          total: 30)
        }
    
    static func getNilCharacteres() -> Characters {
        return Characters(characters: nil,
                          total: 0)
        }
}

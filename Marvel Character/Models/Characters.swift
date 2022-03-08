//
//  Characters.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 21/2/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import Foundation


struct Characters {
    let characters: [Character]?
    let total: Int?
}


struct Character {
    let id: Int?
    let name: String?
    let imagePath: URL?
    
    let stories: [Storie]?
    let comics: [Comic]?
    
    init(id: Int?, name: String?, imagePath: String?, imageExtension: String?, stories: [Storie]? = nil, comics: [Comic]? = nil) {
        self.id = id
        self.name = name
        self.imagePath = URL(string: imagePath ?? "")?.appendingPathExtension(imageExtension ?? "")
        self.stories = stories
        self.comics = comics
    }
   
}


struct Comic {
    let title: String
}

struct Storie {
    let title: String
}

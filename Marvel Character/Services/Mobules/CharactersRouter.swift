//
//  CharactersRouter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 23/2/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import Foundation

fileprivate enum CharacterConstants {
    static let kNameStartsWith = "nameStartsWith"
    static let kOffset = "offset"
    static let kOrderBy = "orderBy"
    static let kLimit = "limit"
}

enum DefaultCharacterRepositoryRouter: MarvelAPIRouter {
    
    case fetchCharactersList(name: String?, orderBy: String?, limit: Int?, offset: Int?)
    case fetchCharacterDetail(id: Int)
    
    var method: MarvelHTTPMethod {
        switch self {
        case .fetchCharactersList, .fetchCharacterDetail:
            return .get
        }
        
    }
    var path: String {
        switch self {
        case .fetchCharactersList( _, _, _, _): return "/characters"
        case .fetchCharacterDetail(let id): return String(format: "/characters/%@", String(id))
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .fetchCharactersList(let name, let orderBy, let limit, let offset):
            var param = [String: Any]()
                param[CharacterConstants.kNameStartsWith] = name
                param[CharacterConstants.kOrderBy] = orderBy
                param[CharacterConstants.kLimit] = limit
                param[CharacterConstants.kOffset] = offset
                
            return param
        default:
            return nil
        }
    }
}

//
//  CharacterListRepository.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 23/2/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import Foundation
import Alamofire

protocol CharacterRepository {
    init(session: API?)
    func getCharacters(offset: Int?, limit: Int?, name: String?, completion: (@escaping (_: Result<CharactersListDTO, NetworkError>) -> Void))
    func getCharacterDetail(id: Int, completion: (@escaping (_: Result<CharacterDTO, NetworkError>) -> Void))
}

final class DefaultCharacterRepository: CharacterRepository {
    private typealias router = DefaultCharacterRepositoryRouter
    private let session: API?
    
    required init(session: API?) {
        self.session = session
    }
    
    func getCharacters(offset: Int?, limit: Int?, name: String?, completion: (@escaping (_: Result<CharactersListDTO, NetworkError>) -> Void)) {
        
        let router = DefaultCharacterRepositoryRouter.fetchCharactersList(name: name, orderBy: nil, limit: limit, offset: offset)
        
        session?.requestObject(from: router , completion: { (result: Result<CharactersListDTO, NetworkError>) in
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let characters):
                completion(.success(characters))
                }
        })
    }
    
    func getCharacterDetail(id: Int, completion: @escaping ((Result<CharacterDTO, NetworkError>) -> Void)) {
        let router = router.fetchCharacterDetail(id: id)
        session?.requestObject(from: router , completion: { (result: Result<CharactersListDTO, NetworkError>) in
            switch result {
            case .success(let characters):
                guard let character = characters.data?.results?.first else {
                    completion(.failure(.unknown))
                    return
                }
                completion(.success(character))
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

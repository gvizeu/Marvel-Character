//
//  CharacterRepositoryMock.swift
//  Marvel CharacterTests
//
//  Created by Gonzalo Vizeu on 8/3/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import Foundation
import XCTest
@testable import Marvel_Character

class CharacterRepositoryMock: CharacterRepository {
    var session: API?
    
    
    required init(session: API?) {
        self.session = session
    }

    func getCharacters(offset: Int?, limit: Int?, name: String?, completion: @escaping ((Result<CharactersListDTO, NetworkError>) -> Void)) {
        
        if name == "MockFail" {
            completion(.failure(.badRequest))
            return
        }
        let expectation = XCTestExpectation(description: "Getting repo")
        session?.requestObject(from: MockAPIRouter.getCharacters, completion: { (result: Result<CharactersListDTO, NetworkError>) in
            
            if case .success(let characteres) = result {
                completion(.success(characteres))
                expectation.fulfill()
            }
        
        })
    }
    
    func getCharacterDetail(id: Int, completion: @escaping ((Result<CharacterDTO, NetworkError>) -> Void)) {
        
    }
}

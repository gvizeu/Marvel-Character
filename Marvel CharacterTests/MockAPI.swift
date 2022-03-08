//
//  MockAPI.swift
//  Marvel CharacterTests
//
//  Created by Gonzalo Vizeu on 23/2/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import UIKit
@testable import Marvel_Character
import XCTest


final class MockAPI: XCTestCase, API {
    func requestObject<T>(from route: MarvelAPIRouter, completion: @escaping ((Result<T, NetworkError>) -> Void)) where T : Decodable {
        
        let expectation = XCTestExpectation(description: "Getting itemo from json file")
        guard let path = Bundle.main.path(forResource: route.path, ofType: "json") else {
            XCTFail("Could not find groceryItems")
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let quizesDTO = try JSONDecoder().decode(T.self, from: data)
            completion(.success(quizesDTO))
            expectation.fulfill()
        } catch  {
            completion(.failure(.decodingError))
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func requestImage(from url: URL, completion: @escaping ((UIImage?) -> Void)) {
        
    }
}

enum MockAPIRouter: MarvelAPIRouter {
    case getCharacters
    case getCharacterDetail

    var method: MarvelHTTPMethod { return .get }
    
    var path: String {
        switch self {
        case .getCharacters: return "characterList"
        case .getCharacterDetail: return "characterDetail"
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    
}

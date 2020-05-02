//
//  CharacterDetailWorker.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

protocol CharacterDetailWorkerDelegate: class {
    func getCharacterDetail(id: Int, completionHandler: (@escaping (CharactersList?, Error?) -> Void))
}

class CharacterDetailWorker: CharacterDetailWorkerDelegate {

    weak var interactor: CharacterDetailBusinessLogic?
    
    func getCharacterDetail(id: Int, completionHandler: (@escaping (CharactersList?, Error?) -> Void)) {
        
        APIMarvel.shared.requestObject(from: MarvelAPIRouter.fetchCharacterDetail(id: id)) {  (result: (Result<CharactersList, Error>)) in
            switch result {
            case .success(let value):
                completionHandler(value, nil)
                
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
            
        
    }
}

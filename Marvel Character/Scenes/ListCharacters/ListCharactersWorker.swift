//
//  ListCharactersWorker.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 19/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

protocol ListCharactersWorkerDelegate: class {
    func getCharacters(withLimit limit: Int?, offset: Int?, withName name: String?, completionHandler: (@escaping (CharactersList?, Error?) -> Void))
}

class ListCharactersWorker: ListCharactersWorkerDelegate {

    func getCharacters(withLimit limit: Int? = 20, offset: Int?, withName name: String?, completionHandler: (@escaping (CharactersList?, Error?) -> Void)){
        APIMarvel.shared.requestObject(from: MarvelAPIRouter.fetchCharactersList(name: name, orderBy: nil, limit: limit, offset: offset), completion: { (result: Result<CharactersList, Error>) in
            
            switch result {
            case .failure(let error as NSError):
                print(error)
                completionHandler(nil, error)
            case .success(let value):
                completionHandler(value, nil)
            }
        
        })
    }
    

}

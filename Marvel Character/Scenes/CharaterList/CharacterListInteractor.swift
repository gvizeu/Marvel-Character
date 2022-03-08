//
//  CharacterListInteractor.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 19/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

protocol CharaterListBusinessLogic: AnyObject {
    func getCharacters(offset: Int?, limit: Int?, name: String?)
}

class CharacterListInteractor: CharaterListBusinessLogic {
    
    weak var presenter: CharacterListPresentersOutput?
    
    fileprivate let repository: CharacterRepository
    
    init(session: CharacterRepository) {
        self.repository = session
    }
    
    func getCharacters(offset: Int?, limit: Int?, name: String?) {
        
        repository.getCharacters(offset: offset, limit: limit, name: name) { result in
            switch result {
            case .success(let characters):
                characters.data.flatMap { data in
                    
                    let characters = data.results?.map({
                        return Character(id: $0.id,
                                         name: $0.name,
                                         imagePath: $0.thumbnail?.path,
                                         imageExtension: $0.thumbnail?.thumbnailExtension)
                    })
                    guard let characters = characters else {
                        self.presenter?.displayError(title: "No characters found", msg: nil)
                        return
                    }
                    let model = Characters(characters: characters, total: data.total)
                    self.presenter?.displayFetchedCharacters(model)
                }
            case .failure(let error):
                self.presenter?.displayError(title: String((error as NSError).code), msg: error.localizedDescription)
            }
        }
    }
}

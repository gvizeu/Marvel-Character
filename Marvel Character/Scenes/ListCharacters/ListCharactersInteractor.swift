//
//  ListCharactersInteractor.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 19/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

protocol ListCharactersBusinessLogic: class {
    func getCharacters(offset: Int?, limit: Int?, name: String?)
}

class ListCharactersInteractor: ListCharactersBusinessLogic {
    
    var worker: ListCharactersWorkerDelegate?
    var presenter: ListCharactersPresentationLogic?
    
    
    func getCharacters() {
        self.getCharacters(offset: nil, limit: nil, name: nil)
    }
    
    func getCharacters(offset: Int?, limit: Int?, name: String?) {
        worker?.getCharacters(withLimit: limit, offset: offset, withName: name, completionHandler: { result, error  in
            if let characters = result {
                if let results = characters.data?.results{
                    self.presenter?.display(characters: results, total: characters.data?.total ?? 0)
                } else {
                    self.presenter?.displayError(title: "error.unknown".localize, msg: nil)
                }
            
            } else if let er = error {
                self.presenter?.displayError(title: String((er as NSError).code), msg: er.localizedDescription)
            }
            
        })
    }
    
    
}

//
//  CharacterDetailInteractor.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

protocol CharacterDetailBusinessLogic: class {
    func getDetail(from id: Int)
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic {
    
    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorkerDelegate?
    
    func getDetail(from id: Int) {
        self.worker?.getCharacterDetail(id: id, completionHandler: { (characterdetails,error)  in
            
            if let details = characterdetails?.data?.results?.first{
                self.presenter?.didGetCharacterDetail(detail: details)
            } else if let er = error {
                self.presenter?.couldntGetDetails(title: String((er as NSError).code), msg: er.localizedDescription)
            }
            
           
        })
    }
    
}

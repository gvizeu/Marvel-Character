//
//  CharacterDetailInteractor.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

protocol CharacterDetailBusinessLogic: AnyObject {
    func getDetail(from id: Int)
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic {
    
    weak var presenter: CharacterDetailPresentationLogic?
    fileprivate let session: CharacterRepository
    
    init(session: CharacterRepository) {
        self.session = session
    }
    
    func getDetail(from id: Int) {
        session.getCharacterDetail(id: id) { result in
            switch result {
            case .success(let characterDTO):
                let stories: [Storie]? = characterDTO.stories?.items?.map({Storie(title: $0.name ?? "")})
                let comics: [Comic]? = characterDTO.comics?.items?.map({Comic(title: $0.name ?? "")})
            
                let character = Character(id: characterDTO.id,
                                          name: characterDTO.name,
                                          imagePath: characterDTO.thumbnail?.path,
                                          imageExtension: characterDTO.thumbnail?.thumbnailExtension,
                                          stories: stories,
                                          comics: comics)
                
                self.presenter?.didGetCharacterDetail(detail: character)
                    
            case .failure(let error):
                self.presenter?.couldntGetDetails(title: String((error as NSError).code), msg: error.localizedDescription)
            }
        }

    }
    
}

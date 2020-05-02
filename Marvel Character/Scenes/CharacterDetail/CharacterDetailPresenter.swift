//
//  CharacterDetailPresenter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

protocol CharacterDetailPresentationLogic: class {
    func didGetCharacterDetail(detail: CharactersList.DataRawValue)
    func couldntGetDetails(title: String?, msg: String?)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    
    var viewController: CharacterDetailDisplayLogic?
    
    func didGetCharacterDetail(detail: CharactersList.DataRawValue){
        self.viewController?.displayDetails(detail)
        self.viewController?.displayStories(stories: detail.stories)
        self.viewController?.displayComics(comics: detail.comics)
    }
    
    func couldntGetDetails(title: String?, msg: String?) {
        self.viewController?.displayError(title: title, msg: msg)
    }
}

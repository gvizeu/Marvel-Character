//
//  CharacterDetailPresenter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

protocol CharacterDetailPresentationLogic: AnyObject {
    func fetchData(from id: Int)
    func didGetCharacterDetail(detail: Character)
    func couldntGetDetails(title: String?, msg: String?)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    
    weak var viewController: CharacterDetailDisplayLogic?
    var interactor: CharacterDetailBusinessLogic?
    var router: CharaterDetailRouterDelegate?
    
    func didGetCharacterDetail(detail: Character){
        self.viewController?.displayDetails(detail)
        self.viewController?.displayStories(stories: detail.stories)
        self.viewController?.displayComics(comics: detail.comics)
    }
    
    func couldntGetDetails(title: String?, msg: String?) {
        self.viewController?.displayError(title: title, msg: msg)
    }
    
    func fetchData(from id: Int) {
        self.interactor?.getDetail(from: id)
    }
}

//
//  CharacterListPresenter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 19/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

protocol CharacterListPresentersOutput: AnyObject {
    func displayFetchedCharacters(_ model: Characters)
    func displayError(title: String?, msg: String?)
}

protocol CharacterListPresenterInput: AnyObject {
    func getCharacters()
    func getCharacters(by name: String)
    func getMoreCharacters(loadedCharateres: Int, name: String)
    func setDataLoading(_ isDataLoading: Bool)
    
    func navigateToCharacterDetail(with id: Int)
    func didFinishFiltering()
    
}

class CharaterListPresenter {
    
    weak var viewController: CharacterListDisplayLogic?
    var interactor: CharaterListBusinessLogic?
    var router: ListCharacterRoutingLogic?
    
    private var isDataLoading = false
    private var offset: Int = 0
    private var totalCharacters: Int = 0
    
    fileprivate func fetchCharacters(offset: Int?, name: String) {
        interactor?.getCharacters(offset: offset,
                                       limit: 20,
                                       name: name.isEmpty ? nil : name)
    }
    
    fileprivate func canFetchMoreCharacters() -> Bool {
        (totalCharacters - offset) > 0
    }
    
    fileprivate func fetchMoreCharacters(name: String) {
        viewController?.showTableViewLoader()
        fetchCharacters(offset: offset, name: name)
    }
    
    fileprivate func displayCharacters(model: Characters){
        if let characters = model.characters,
           characters.count > 0 {
            if offset == 0 {
                viewController?.displayCharacters(characters)
            } else {
                viewController?.displayAppendingCharacters(characters)
            }
            self.totalCharacters = model.total ?? 0
        } else {
            self.viewController?.displayError(title: "error.noCharacters".localize, msg: "")
        }
    }
    
}

extension CharaterListPresenter: CharacterListPresenterInput {
    func getCharacters() {
        fetchCharacters(offset: 0, name: "")
    }
    
    func getCharacters(by name: String) {
        fetchCharacters(offset: 0, name: name)
    }
    
    func setDataLoading(_ isDataLoading: Bool) {
        self.isDataLoading = isDataLoading
    }
    
    func getMoreCharacters(loadedCharateres: Int, name: String) {
        if !isDataLoading  {
            isDataLoading = true
            offset = loadedCharateres
            if canFetchMoreCharacters() {
                fetchMoreCharacters(name: name)
            }
        }
    }
    
    func navigateToCharacterDetail(with id: Int) {
        self.router?.navigateToCharacterDetail(with: id)
    }
    
    func didFinishFiltering() {
        offset = 0
        fetchCharacters(offset: offset, name: "")
    }
}

extension CharaterListPresenter: CharacterListPresentersOutput {

    func displayFetchedCharacters(_ model: Characters) {
        displayCharacters(model: model)
    }
    
    func displayError(title: String?, msg: String?) {
        self.viewController?.displayError(title: title, msg: msg)
    }
}

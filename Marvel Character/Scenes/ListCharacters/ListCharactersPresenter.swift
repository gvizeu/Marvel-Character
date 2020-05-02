//
//  ListCharactersPresenter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 19/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit
protocol ListCharactersPresentationLogic: class {
    func display(characters: [CharactersList.DataRawValue], total: Int)
    func displayError(title: String?, msg: String?)
}

class ListCharactersPresenter: ListCharactersPresentationLogic {
    
    weak var viewController: ListCharactersDisplayLogic?
    
    func display(characters: [CharactersList.DataRawValue], total: Int) {
        if characters.count > 0 {
            self.viewController?.displayCharacters(characters: characters, total: total)
        } else {
            self.viewController?.displayError(title: "error.noCharacters".localize, msg: "")
        }
       
        
    }
    
    func displayError(title: String?, msg: String?) {
        self.viewController?.displayError(title: title, msg: msg)
    }
    
    
    
    
}

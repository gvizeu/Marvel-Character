//
//  CharactersListRouter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

protocol ListCharacterRoutingLogic: class{
    func navigateToCharacterDetail(with id: Int)
}

class ListCharactersRouter: ListCharacterRoutingLogic {
    
    var viewController: ListCharactersViewController?
    
    func navigateToCharacterDetail(with id: Int){
        
        let detailVC = CharacterDetailViewController.makeCharacterDetailView(id: id)
        self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
        
        
        
    }
}

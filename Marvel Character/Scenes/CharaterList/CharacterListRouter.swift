//
//  CharactersListRouter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation
import UIKit

protocol ListCharacterRoutingLogic: AnyObject {
    func navigateToCharacterDetail(with id: Int)
}

class CharacterListRouter: ListCharacterRoutingLogic {
    
    fileprivate var viewController: CharacterListViewController?
    fileprivate var session: CharacterRepository!
    
    static func createModule(from session: CharacterRepository) -> CharacterListViewController{
        let viewController = CharacterListViewController(nibName: "CharacterListViewController", bundle: nil)
        let interactor = CharacterListInteractor(session: session)
        let presenter = CharaterListPresenter()
        let router = CharacterListRouter()
        router.session = session
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
    func navigateToCharacterDetail(with id: Int){
        let detailVC = CharaterDetailRouter.createModule(with: id, session: session)
        self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
        
        
        
    }
}

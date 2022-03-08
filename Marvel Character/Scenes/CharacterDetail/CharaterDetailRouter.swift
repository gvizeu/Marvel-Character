//
//  CharaterDetailRouter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 4/2/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import Foundation
import UIKit

protocol CharaterDetailRouterDelegate: AnyObject {
    
}

class CharaterDetailRouter: CharaterDetailRouterDelegate {
    
    static func createModule(with id: Int, session: CharacterRepository) -> CharacterDetailViewController{
    
        let viewController = CharacterDetailViewController(nibName: "CharacterDetailViewController", bundle: nil)
        let presenter = CharacterDetailPresenter()
        let interactor = CharacterDetailInteractor(session: session)
        let router = CharaterDetailRouter()
        viewController.identifier = id
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.viewController = viewController
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController
    }
    
}

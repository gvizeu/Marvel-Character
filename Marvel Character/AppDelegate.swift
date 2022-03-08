//
//  AppDelegate.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 16/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let session = DefaultCharacterRepository(session: APIMarvel())
        window?.rootViewController = UINavigationController(rootViewController: CharacterListRouter.createModule(from: session))
        window?.makeKeyAndVisible()
        
        return true
    }
}


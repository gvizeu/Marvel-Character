//
//  Environment.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 18/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

public enum Environment {
    enum Keys {
        static let rootURL = "MARVEL_ROOT_URL"
        static let MarvelPrivate = "MARVEL_PRIVATE_KEY"
        static let MarvelPublic = "MARVEL_PUBLIC_KEY"
    }
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let rootURL: URL = {
        guard let rootURLstring = Environment.infoDictionary[Keys.rootURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        
        guard let url = URL(string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        
        return url
    }()
    static let marvelKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.MarvelPublic] as? String else {
            fatalError("Marvel Api Key not set in plist for this environment")
        }
        
        return apiKey
    }()
    
    static let marvelHash: String = {
        guard let privateKey = Environment.infoDictionary[Keys.MarvelPrivate] as? String else {
                   fatalError("Marvel private Key not set in plist for this environment")
               }
        let ts = "1"
        let publicKey = Environment.marvelKey
        
        let string = ts+privateKey+publicKey
        let md5Hex =  string.MD5().map { String(format: "%02hhx", $0) }.joined()
        
        return md5Hex
    }()
}


//
//  MarvelRouter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 18/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum RouterConstants {
    static let kHash = "hash"
    static let kApiKey = "apikey"
    static let kTs = "ts"
}

protocol MarvelAPIRouter: APIRouter {
    var baseURLString: String { get }
}

extension MarvelAPIRouter {
    
    var baseURLString: String {
        Environment.rootURL.absoluteString
    }
    
    var defaultParams: [String: Any] {
        return [RouterConstants.kHash: Environment.marvelHash,
                RouterConstants.kApiKey: Environment.marvelKey,
                RouterConstants.kTs: 1]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        if var params = parameters {
            params.merge(dict: defaultParams)
             urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        } else {
             urlRequest = try URLEncoding.default.encode(urlRequest, with: defaultParams)
        }
        return urlRequest
    }
}
extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}



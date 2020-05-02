//
//  MarvelRouter.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 18/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation
import Alamofire
enum MarvelAPIRouter: URLRequestConvertible {
    
    case fetchCharactersList(name: String?, orderBy: String?, limit: Int?, offset: Int?)
    case fetchCharacterDetail(id: Int)
    
    var method: HTTPMethod{
        switch self {
        case .fetchCharactersList, .fetchCharacterDetail:
            return .get
        }
        
    }
    static let baseURLString = Environment.rootURL.absoluteString
    
    var path: String {
        switch self {
        case .fetchCharactersList( _, _, _, _): return kCharacters
        case .fetchCharacterDetail(let id): return String(format: kCharacterDetail, String(id))
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchCharactersList(let name, let orderBy, let limit, let offset):
            var param = [String: Any]()
            if name != nil{
                param[kNameStartsWith] = name
            }
            if orderBy != nil {
                param[kOrderBy] = orderBy
            }
            if limit != nil {
                param[kLimit] = limit
            }
            
            if offset != nil {
                param[kOffset] = offset
            }
                
            return param
        default:
            return nil
        }
    }
    var defaultParams: [String: Any]{
        return [kHash: Environment.marvelHash,
                kApiKey: Environment.marvelKey,
                kTs: 1]
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try MarvelAPIRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .fetchCharactersList, .fetchCharacterDetail:
            var params = parameters
            if params != nil{
                params?.merge(dict: defaultParams)
                 urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            } else {
                 urlRequest = try URLEncoding.default.encode(urlRequest, with: defaultParams)
            }
            
           
            
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



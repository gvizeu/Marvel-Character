//
//  APIProtocols.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 20/2/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import Foundation
import Alamofire


protocol APIRouter: URLRequestConvertible {
    var method: MarvelHTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var defaultParams: [String: Any] { get }
}

protocol API {
    func requestObject<T: Decodable>(from route: MarvelAPIRouter, completion: (@escaping (_: Result<T, NetworkError>) -> Void))
    func requestImage(from url: URL, completion: (@escaping (UIImage?) -> Void))
}

extension API {

}

enum MarvelHTTPMethod: String {
    case get, put, post, delete
    
}

enum NetworkError: Error {
    case generic(code: Int?, description: String?)
    case badRequest
    case decodingError
    case badURL
    case unknown
}

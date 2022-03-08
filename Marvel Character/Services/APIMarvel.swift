//
//  APIMarvel.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 18/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

final class APIMarvel: API {
    
    lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
    
        configuration.headers = .default
        
        return Session(configuration: configuration)
    }()
    
    private let imageCache = AutoPurgingImageCache( memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)

    func requestObject<T: Decodable>(from route: MarvelAPIRouter, completion: @escaping ((Result<T, NetworkError>) -> Void)) {
        sessionManager.request(route).responseDecodable(of: T.self) { response in
          
            guard let resp = response.response,
                (200...300).contains(resp.statusCode) else {
                    
                    if let data = response.data {
                        let decodedData = try? JSONDecoder().decode(GenericError.self, from: data)
                        
                        if let errorMessage = decodedData?.status {
                            completion(.failure(.generic(code: decodedData?.code, description: errorMessage)))
                            return
                        }
                    } else {
                        completion(.failure(.generic(code: response.response?.statusCode, description: response.response?.description)))
                        return
                    }
                    return
            }
            switch response.result {
            case .failure(let error):
                completion(Result.failure(.generic(code: error.responseCode, description: error.errorDescription)))
            case .success(let value):
                completion(Result.success(value))
            }
        }
    }
    
    func requestImage(from url: URL, completion: (@escaping (UIImage?) -> Void)) {
        if let image = imageCache.image(withIdentifier: url.relativePath){
            completion(image)
        } else {
            DispatchQueue.main.async {
                self.sessionManager.request(url).responseImage { response in

                    if case .success(let image) = response.result {
                        self.imageCache.add(image, withIdentifier: url.relativePath)
                        completion(image)
                    }
                }
            }
            

        }
        
    }
}

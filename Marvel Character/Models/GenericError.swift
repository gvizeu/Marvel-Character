//
//  GenericError.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 20/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import Foundation

// MARK: - GenericResponse
struct GenericResponse: Codable {
    var status: Int
    var message: String?
}

// MARK: - GenericError
struct GenericError: Error, Codable {
    let code: Int
    let status: String?
}

enum AppError: Error {
    case message(String)
    case generic
    case malformedData
    
    public var errorDescription: String? {
        switch self {
        case .message(let message): return message
        case .generic: return ""
        default: return ""
        }
    }
}

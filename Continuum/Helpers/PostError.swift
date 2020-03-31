//
//  PostError.swift
//  Continuum
//
//  Created by Anthroman on 3/31/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import Foundation

enum PostError: LocalizedError {
    case thrown(Error)
    case invalidURL
    case noData
    case badData
    case unableToDelete
    
    var errorDescription: String? {
        switch self {
            
        case .thrown(let error):
            return error.localizedDescription
        case .invalidURL:
            return "Unable to reach server."
        case .noData:
            return "Server responded with no data."
        case .badData:
            return "Server responded with bad data."
        case .unableToDelete:
            return "Unable to delete."
        }
    }
}

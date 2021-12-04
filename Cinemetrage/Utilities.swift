//
//  Utilities.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 03/12/21.
//

import Foundation

class Utilities {
    
    static let jsonDecoder : JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
}

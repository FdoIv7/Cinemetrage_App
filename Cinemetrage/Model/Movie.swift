//
//  Movie.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 02/12/21.
//

import Foundation

struct MovieResponse : Decodable {
    let results : [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Movie : Decodable {
    
    let id : Int
    let title : String
    let backdropPath : String?
    let posterPath : String?
    let overview : String
    let voteAverage : Double
    let voteCount : Int
    
    //Supply coding keys for our properties
    private enum CodingKeys: String, CodingKey {
        case title
        case overview
        case id = "id"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
    }
}

struct GenreIdsInfo : Decodable {
    let genreIds : [Int]
}



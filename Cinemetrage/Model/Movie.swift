//
//  Movie.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 02/12/21.
//

import Foundation

struct MovieResponse : Decodable {
    let results : [Movie]
}

struct Movie : Decodable {
    
    let id : Int
    let title : String
    let backdropPath : String?
    let posterPath : String?
    let overview : String
    let voteAverage : Double
    let voteCount : Int
    let runtime : Int? 

}



//
//  MovieService.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 03/12/21.
//

import Foundation

//Class for MovieService setup
protocol MoviesProtocol {
    //Methods for our movie service
    func popularMovies(completion: @escaping(Result<MovieResponse, Error>) -> Void)
    func upcomingMovies(completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func topRatedMovies(completion: @escaping(Result<MovieResponse,Error>) -> Void)
}

//
//  MovieService.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 03/12/21.
//

import Foundation

//Class for MovieService setup
protocol MovieService {
    //Methods for our movie service
    func fetchMovies(from endPoint: MovieDBEndPoint, completion: @escaping(Result<MovieResponse, MovieError>) -> Void)
    func fetchSingleMovie(id: Int, completion: @escaping(Result <Movie, MovieError>) -> Void)
    func fetchGenres(genreID: Int, completion: @escaping(Result<MovieResponse, MovieError>) -> Void)
    func searchMovie(query: String, completion: @escaping(Result<MovieResponse, MovieError>) -> Void)

}

//enum to represent MovieDB API Endpoints
enum MovieDBEndPoint: String, CaseIterable {
    //We use popular and upcoming string raw value
    //Override the default value for topRated to use snake_case
    //Gonna append the raw value to the URLPath of the movieDB API
    case popular
    case topRated = "top_rated"
    case upcoming
    
    //Declare description for each case, so we can show it in the movielist
    var description : String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        }
    }
}

//enum to represent errors when making our API Calls, Confirming to CustomNSError to print error messages properly
enum MovieError: Error, CustomNSError{
    
    /*
     5 cases:
     apiError = Generic Error
     invalidEndPoint = Error when constructing the endPoint URL
     invalidResponse = HTTP Response is not in the range of 200 - 300
     noData = We didn't get any data
     serializationError = JSON Decoding error
     */
    
    case apiError
    case invalidEndPoint
    case invalidResponse
    case noData
    case serializationError
    
    //To show error to the users
    var localizedDescription : String{
        switch self {
        case .apiError: return "Failure fetching data"
        case .invalidEndPoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failure decoding data"
        }
    }
    
    //declare errorUserInfo
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}

//
//  MoviePresenter.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 02/12/21.
//

import Foundation

//Concrete class that implements the MovieService
class MoviePresenter : MovieService {
    
    //Singleton pattern for this class
    //Private init to make sure only this class can make instances of itself
    static let shared = MoviePresenter()
    private init(){
        
    }
    
    private let apiKey = "bb32b5e85ce5577c16bb1b12df7018fa"
    private let baseAPIUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utilities.jsonDecoder //Got our decoder and formatter from utilities
    private let formatter = Utilities.dateFormatter
    
    
    func fetchMovies(from endPoint: MovieDBEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        <#code#>
    }
    
    func fetchSingleMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> Void) {
        <#code#>
    }
    
    func fetchGenres(genreID: Int, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        <#code#>
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        <#code#>
    }
    
    private func loadAndDecodeURL(with url: URL, params: [String : String]? = nil, completion: @escaping (Result<Decodable, MovieError>) -> Void){
        
        //URLComponents init returns an optional URLComponents object
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        //Declare our queryItems
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        //Unwrap our params
        if let safeParams = params{
            //Map our params transforming it into an array of URLQueryItem by mapping key and value
            queryItems.append(contentsOf: safeParams.map{URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        //Get our finalURL
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        //Use URLSessionDataTask to make our request
        urlSession.dataTask(with: finalURL) { data, response, error in
            if error != nil {
                completion(.failure(.apiError))
            }
        }
        
    }
}

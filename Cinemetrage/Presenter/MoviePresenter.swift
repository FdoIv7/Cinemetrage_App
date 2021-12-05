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
        //Declare our url
        guard let url = URL(string: "\(baseAPIUrl)/movie/\(endPoint.rawValue)") else {
            //If the url is nil, execute completion handler
            completion(.failure(.invalidEndPoint))
            return
        }
        
        //URL Not nil, we can safely loadAndDecode our URL
        loadAndDecodeURL(with: url, completion: completion)
        
    }
    
    func fetchSingleMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> Void) {
        guard let url = URL(string: "\(baseAPIUrl)/movie/\(id)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        //Append extra params
        loadAndDecodeURL(with: url, params: [
            "append_to_response" : "video, credits"
        ], completion: completion)
    }
    
    func fetchGenres(genreID: Int, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        //Declare our url
        guard let url = URL(string: "\(baseAPIUrl)/genre/movie/list") else {
            //If the url is nil, execute completion handler
            completion(.failure(.invalidEndPoint))
            return
        }
        loadAndDecodeURL(with: url, completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        //Declare our url
        guard let url = URL(string: "\(baseAPIUrl)/search/movie/") else {
            //If the url is nil, execute completion handler
            completion(.failure(.invalidEndPoint))
            return
        }
        
        //Append the query to params
        loadAndDecodeURL(with: url, params: [
            "language" : "en-US",
            "include_adult" : "false",
            "region" : "US",
            "query" : query,
        ], completion: completion)
    }
    
    //We set optional params in case we need to pass extra parameters
    private func loadAndDecodeURL<D: Decodable>(with url: URL, params: [String : String]? = nil, completion: @escaping (Result<D, MovieError>) -> Void){
        
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
        urlSession.dataTask(with: finalURL) { [weak self] data, response, error in
            
            guard let self = self else { return }
        
            if error != nil {
                //Since the completion handler is being called in the background, make sure to call it in the main thread
                self.executeCompletionMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            //Convert the urlResponse to a HTTPURLResponse type
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                //error - invalid response
                self.executeCompletionMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            if httpUrlResponse.statusCode >= 200 && httpUrlResponse.statusCode < 300 {
                //We got a valid response
                print("We got a valid HTTPUrlResponse - Success!")
            } else {
                self.executeCompletionMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let safeData = data else {
                //Our data was nil
                self.executeCompletionMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            //Decode our data with JSONDecoder
            do {
                //Pass the success decodedData as the value
                let decodedData = try self.jsonDecoder.decode(D.self, from: safeData)
                self.executeCompletionMainThread(with: .success(decodedData), completion: completion)
            } catch {
                self.executeCompletionMainThread(with: .failure(.serializationError), completion: completion)
            }
        }
        
        //Resume our data task
        urlSession.dataTask(with: finalURL).resume()
    }
    
    //Helper method to run our completion in the main thread
    private func executeCompletionMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> Void){
        
        DispatchQueue.main.async {
            completion(result)
        }
        
    }
}

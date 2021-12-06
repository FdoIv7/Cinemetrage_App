//
//  MoviePresenter.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 02/12/21.
//

import Foundation
import UIKit

//Concrete class that implements the MovieService
class MoviesAPIService : MoviesProtocol {
    
    private let apiKey = "bb32b5e85ce5577c16bb1b12df7018fa"
    private let baseAPIUrl = "https://api.themoviedb.org/3"
    private var dataTask : URLSessionTask?
        
    func upcomingMovies(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        
        let upcomingMoviesURL = "\(baseAPIUrl)" + "/movie/upcoming?api_key=" + "\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: upcomingMoviesURL) else { return }
        
        //Create our URLSession and work on the bg
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //Handle our errors
            if let error = error {
                completion(.failure(error))
                print("Data Task error = \(error)")
            }
            
            //Check if we got a response
            guard let response = response as? HTTPURLResponse else {
                //Empty response
                print("Empty response")
                return
            }
                    
            print("Response Status Code = \(response.statusCode)")
            
            guard let data = data else {
                //No data
                print("Empty data")
                return
            }
            
            //Parse our data
            do {
                //Decode data to a MovieResponse
                let decoder = JSONDecoder()
                let jsonMovieResponse = try decoder.decode(MovieResponse.self, from: data)
                        
                DispatchQueue.main.async {
                    //print("Got jsonMovieResponse \(jsonMovieResponse)")
                    completion(.success(jsonMovieResponse))
                }
            } catch {
                //Potential errors
                print(" - Error decoding our data \(error)")
                completion(.failure(error))
            }
        }
        
        self.dataTask?.resume()
    }
    
    func popularMovies(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
                
        let popularMoviesURL = "\(baseAPIUrl)" + "/movie/popular?api_key=" + "\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: popularMoviesURL) else { return }
        
        //Create our URLSession and work on the bg
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //Handle our errors
            if let error = error {
                completion(.failure(error))
                print("Data Task error = \(error)")
            }
            
            //Check if we got a response
            guard let response = response as? HTTPURLResponse else {
                //Empty response
                print("Empty response")
                return
            }
                    
            print("Response Status Code = \(response.statusCode)")
            
            guard let data = data else {
                //No data
                print("Empty data")
                return
            }
            
            //Parse our data
            do {
                //Decode data to a MovieResponse
                let decoder = JSONDecoder()
                let jsonMovieResponse = try decoder.decode(MovieResponse.self, from: data)
                        
                DispatchQueue.main.async {
                    //print("Got jsonMovieResponse \(jsonMovieResponse)")
                    completion(.success(jsonMovieResponse))
                }
            } catch {
                //Potential errors
                print(" - Error decoding our data \(error)")
                completion(.failure(error))
            }
        }
        
        self.dataTask?.resume()
        
    }
    
    func topRatedMovies(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
                
        let topRatedMoviesURL = "\(baseAPIUrl)" + "/movie/top_rated?api_key=" + "\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: topRatedMoviesURL) else {
            return }
        
        //Create our URLSession and work on the bg
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //Handle our errors
            if let error = error {
                completion(.failure(error))
                print("Data Task error = \(error)")
            }
            
            //Check if we got a response
            guard let response = response as? HTTPURLResponse else {
                //Empty response
                print("Empty response")
                return
            }
                    
            print("Response Status Code = \(response.statusCode)")
            
            guard let data = data else {
                //No data
                print("Empty data")
                return
            }
            
            //Parse our data
            do {
                //Decode data to a MovieResponse
                let decoder = JSONDecoder()
                let jsonMovieResponse = try decoder.decode(MovieResponse.self, from: data)
                        
                DispatchQueue.main.async {
                    //print("Got jsonMovieResponse \(jsonMovieResponse)")
                    completion(.success(jsonMovieResponse))
                }
            } catch {
                //Potential errors
                print(" - Error decoding our data \(error)")
                completion(.failure(error))
            }
        }
        
        self.dataTask?.resume()
    }
}

//
//  MovieViewModel.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 05/12/21.
//

import Foundation

class MovieViewModel {
    private var movieService = MoviesAPIService()
    private var popularMovies = [Movie]()
    private var topRatedMovies = [Movie]()
    private var upcomingMovies = [Movie]()
    
    enum moviesToGet {
        case popular
        case topRated
        case upcoming
    }
    
    //Get our popular movies
    func getPopularMoviesData(completion: @escaping () -> ()) {
        movieService.popularMovies { [weak self] (result) in
            switch result {
            case .success(let listOf):
                //Assign results to popularMovies array
                self?.popularMovies = listOf.results
                completion()
            case .failure(let error):
                print("JSON parsing error \(error)")
            }
        }
    }
    
    //Get our upcoming movies
    func getUpcomingMovies(completion: @escaping () -> ()){
        movieService.upcomingMovies { [weak self] result in
            switch result {
            case .success(let listOf):
                //Assign results to upcomingMovies array
                print("We got movies \(listOf.results)")
                self?.upcomingMovies = listOf.results
                completion()
            case .failure(let error):
                print("JSON parsing error \(error)")
            }
        }
    }
    
    //Get our topRated movies
    func getTopRatedMovies(completion: @escaping () -> ()){
        movieService.topRatedMovies { [weak self] result in
            switch result {
            case .success(let listOf):
                //Assign results to topRatedMovies array
                self?.topRatedMovies = listOf.results
                completion()
            case .failure(let error):
                print("JSON parsing error \(error)")
            }
        }
    }
    
    //Method for returning the number of items in the collectionView
    func numberOfItemsInSection(forList: moviesToGet, section: Int) -> Int {
                
        switch forList {
        case .popular:
            if popularMovies.count != 0 {
                return popularMovies.count
            }
        case .topRated:
            if topRatedMovies.count != 0 {
                return topRatedMovies.count
            }
        case .upcoming:
            if upcomingMovies.count != 0 {
                return upcomingMovies.count
            }
        }
        return 1
    }
    
    //Method for assigning a Movie to each collectionView cell
    func itemForRowAt(forList: moviesToGet, indexPath: IndexPath) -> Movie {
        switch forList {
        case .popular:
            return popularMovies[indexPath.row]
        case .topRated:
            return topRatedMovies[indexPath.row]
        case .upcoming:
            return upcomingMovies[indexPath.row]
        }
    }
}

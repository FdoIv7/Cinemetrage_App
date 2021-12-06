//
//  HomeViewController.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 05/12/21.
//

import UIKit

class HomeViewController: UIViewController {

    var upcomingMovies = [Movie]()
    var popularMovies = [Movie]()
    var topRatedMovies = [Movie]()
    var movieForDetail : Movie?

    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
    private let movieService = MoviesAPIService()
    private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cinemetrage"
        registerCells()
        loadTopRatedMovies()
        loadUpcomingMovies()
        loadPopularMovies()
        
    }
    
    private func registerCells(){
        upcomingCollectionView.register(UINib(nibName: "PosterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        popularCollectionView.register(UINib(nibName: "PosterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        topRatedCollectionView.register(UINib(nibName: "PosterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    private func loadUpcomingMovies(){
        viewModel.getUpcomingMovies { [weak self] in
            self?.upcomingCollectionView.delegate = self
            self?.upcomingCollectionView.dataSource = self
            self?.upcomingCollectionView.reloadData()
        }
    }
    
    private func loadPopularMovies() {
        viewModel.getPopularMoviesData { [weak self] in
            self?.popularCollectionView.delegate = self
            self?.popularCollectionView.dataSource = self
            self?.upcomingCollectionView.reloadData()
        }
    }
    
    private func loadTopRatedMovies(){
        viewModel.getTopRatedMovies { [weak self] in
            self?.topRatedCollectionView.delegate = self
            self?.topRatedCollectionView.dataSource = self
            self?.topRatedCollectionView.reloadData()
        }
    }
        
}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch collectionView {
        case upcomingCollectionView:
            return viewModel.numberOfItemsInSection(forList: .upcoming, section: section)
        case popularCollectionView:
            return viewModel.numberOfItemsInSection(forList: .popular, section: section)
        case topRatedCollectionView:
            return viewModel.numberOfItemsInSection(forList: .topRated, section: section)
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case upcomingCollectionView:
            let movie = viewModel.itemForRowAt(forList: .upcoming, indexPath: indexPath)
            movieForDetail = movie
            performSegue(withIdentifier: "toMovieDetailVC", sender: self)
            print(movie.title)
        case popularCollectionView:
            let movie = viewModel.itemForRowAt(forList: .popular, indexPath: indexPath)
            movieForDetail = movie
            performSegue(withIdentifier: "toMovieDetailVC", sender: self)
            print(movie.title)
        case topRatedCollectionView:
            let movie = viewModel.itemForRowAt(forList: .topRated, indexPath: indexPath)
            movieForDetail = movie
            performSegue(withIdentifier: "toMovieDetailVC", sender: self)
            print(movie.title)
        default:
            print("no movie availbale")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! PosterCollectionViewCell
        
        //Get movie to setup cell
        switch collectionView {
        case upcomingCollectionView:
            let movie = viewModel.itemForRowAt(forList: .upcoming, indexPath: indexPath)
            cell.setupCell(with: movie)
        case popularCollectionView:
            let movie = viewModel.itemForRowAt(forList: .popular, indexPath: indexPath)
            cell.setupCell(with: movie)
        case topRatedCollectionView:
            let movie = viewModel.itemForRowAt(forList: .topRated, indexPath: indexPath)
            cell.setupCell(with: movie)
        default:
            return cell
        }
        return cell
    }
}

//MARK: - Segue Methods

extension HomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetailVC"{
            let destinationVC = segue.destination as! MovieDetailViewController
            destinationVC.movie = self.movieForDetail
        }
    }
    
}

//
//  MovieDetailViewController.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 05/12/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie? = nil
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    private var urlString : String = ""
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieBackDropImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var overViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        updateBackDropImage(backdrop: movie?.backdropPath)
        self.movieLabel.text = movie?.title
        self.ratingLabel.text = "Rating: \(movie!.voteAverage)"
        self.overViewLabel.text = movie?.overview
        overViewContainer.layer.cornerRadius = 8
        overViewContainer.layer.masksToBounds = true
        
    }
    
    //Update/Setup Cell
    private func updateBackDropImage(backdrop: String?){
        
        guard let backdropString = backdrop else {return}
        urlString = baseImageURL + backdropString
        
        guard let backdropURL = URL(string: urlString) else {
            //Handle no image for poster
            print("we got no backdrop image")
            return
        }
        
        //Clear backdropImage before downloading the new data
        self.movieBackDropImage.image = nil
        movieBackDropImage.layer.cornerRadius = 8
        movieBackDropImage.layer.masksToBounds = true
        getImageData(from: backdropURL)
    }
    
    //Get image data
    private func getImageData(from url: URL){
        URLSession.shared.dataTask(with: url) { data, response, error in
            //Handle errors
            if let error = error {
                print("dataTask error \(error.localizedDescription)")
                return
            }
            
            //Handle no data
            guard let data = data else {
                print("No data")
                return
            }
            
            //Update our image in the main thread
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.movieBackDropImage.image = image
                }
            }
        }.resume()
    }
}

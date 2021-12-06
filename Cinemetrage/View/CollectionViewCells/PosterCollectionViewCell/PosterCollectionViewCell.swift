//
//  PosterCollectionViewCell.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 05/12/21.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    let baseImageURL = "https://image.tmdb.org/t/p/w300"
    private var urlString : String = ""
    
    func setupCell(with movie: Movie){
        updatePosterImage(poster: movie.posterPath)
    }
    
    //Update/Setup Cell
    private func updatePosterImage(poster: String?){
        
        guard let posterString = poster else {return}
        urlString = baseImageURL + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            //Handle no image for poster
            print("we got no poster image")
            return
        }
        
        //Clear posterImage before downloading the new data
        self.posterImageView.image = nil
        self.posterImageView.layer.cornerRadius = 8
        self.posterImageView.layer.masksToBounds = true
        getImageData(from: posterImageURL)
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
                    self.posterImageView.image = image
                }
                
            }
        }.resume()
    }

}

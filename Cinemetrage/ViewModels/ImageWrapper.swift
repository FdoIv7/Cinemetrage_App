//
//  ImagePresenter.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 05/12/21.
//

import Foundation
import UIKit

private let globalImageCache = NSCache<AnyObject, AnyObject>()

protocol ImagePresenterDelegate : AnyObject {
    func presentImages(images: [UIImage])
}

class ImageWrapper {
    
    var image : UIImage?
    var isLoading : Bool = false
    
    var imgCache = globalImageCache
    
    func loadImage(with url: URL){
        let urlString = url.absoluteString
        
        //Assign our urlString to a variable, to get our key to retrieve images from cache
        if let imageFromCache = globalImageCache.object(forKey: urlString as AnyObject) as? UIImage {
            //If image exists, assign it to the image property
            self.image = imageFromCache
        }
        
        //Change to back thread to download image
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {return}
            
            do{
                let data = try Data(contentsOf: url)
                //If we get data successfully, initialize a UIImage with data
                guard let image = UIImage(data: data) else{
                    return
                }
                //Cache it setting the urlString as the key
                self.imgCache.setObject(image, forKey: urlString as AnyObject)
                
                //Change back to main thread to update our image property
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                
            }
        }
    }
    
}


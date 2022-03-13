//
//  ImageCollectionViewCell.swift
//  Exercise5
//
//  Created by Oren Dinur on 06/03/2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var image: UIImage? {
       get {
           return imageView.image
       }
       set {
           imageView.image = newValue
           spinner?.stopAnimating()
           self.addSubview(imageView)
       }
   }
}


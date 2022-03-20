//
//  ImageCollectionViewCell.swift
//  Exercise5
//
//  Created by Oren Dinur on 06/03/2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
       get {
           return imageView.image
       }
       set {
           imageView.image = newValue
           self.addSubview(imageView)
       }
   }
}


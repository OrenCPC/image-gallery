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
    
    
    //    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var imageURL: URL? {
        didSet {
            image = nil
//            if view.window != nil { //Am I on screen?
                fetchImage()
//            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
//            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if imageView.image == nil {
//            fetchImage()
//        }
//    }
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
//            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents, url == self?.imageURL {
                        self?.image = UIImage(data: imageData)
//                        self.sizeToFit()
//                        self?.addSubview(imageView)
                    }
                }
            }
            
        }
        
    }
    
    
    
    
    
    
    
}

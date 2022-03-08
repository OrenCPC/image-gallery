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
    
    
    var imageURL: URL? {
        didSet {
            image = nil
//            if view.window != nil { //Am I on screen?
                fetchImage()
//            }
        }
    }
    
    var ratio: CGFloat?
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
                if let size = image?.size {
                    ratio = size.width / size.height
                }
                spinner?.stopAnimating()
                self.addSubview(imageView)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if imageView.image == nil {
//            fetchImage()
//        }
//    }
    
//    private func fetchImage() {
//        if let url = imageURL {
//            spinner.startAnimating()
//            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//                let urlContents = try? Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    if let imageData = urlContents, url == self?.imageURL {
//                        self?.image = UIImage(data: imageData)
//                    }
//                }
//
////                {
////                    if let imageData = urlContents, url == self?.imageURL {
////                        self?.image = UIImage(data: imageData)
////                    }
////                }
//            }
//
//        }
//
//    }
    private func fetchImage() {
        print("Im in fetch")
        if let url = imageURL {
            spinner.startAnimating()
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents, url == self.imageURL {
                self.image = UIImage(data: imageData)
            }
        }
    }
    
    
    
    
    
    
    
}

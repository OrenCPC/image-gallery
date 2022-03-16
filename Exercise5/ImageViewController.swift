//
//  ImageViewController.swift
//  Cassini
//
//  Created by Oren Dinur on 28/02/2022.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
   
    var imageView = UIImageView()
    
    var image: UIImage {
        get {
            return imageView.image!
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 3.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}

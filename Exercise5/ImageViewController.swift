//
//  ImageViewController.swift
//  Cassini
//
//  Created by Oren Dinur on 28/02/2022.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var didSegue: Bool? {
        didSet {
            imageView.image = nil
        }
    }
    
    var imageView = UIImageView()
//    var imageView = UIImageView?
    
    var image: UIImage {
        get {
            return imageView.image!
        }
        set {
            print("Sweet")
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        image = nil
    }
    
    
    
}

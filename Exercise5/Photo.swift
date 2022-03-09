//
//  Photo.swift
//  Exercise5
//
//  Created by Oren Dinur on 07/03/2022.
//

import Foundation
import UIKit

struct Photo {
    
    private (set) var didDownloadImage = false
    
    private (set) var image: UIImage?
//    {
//        didSet {
//            if let size = image?.size {
//                width = size.width
//                ratio = width! / size.height
//                didDownloadImage = true
//            }
//        }
//    }
    
    var ratio: CGFloat?
    var width: CGFloat?
    
    private (set) var imageURL : URL?
//    {
//        didSet {
//            image = nil
//            self.fetchImage()
//        }
//    }
    
//    private mutating func fetchImage() {
//        let session = URLSession(configuration: .default)
//        if let url = imageURL {
//
//        let task = session.dataTask(with: url) { (data: Data?, response, error) in
//            image = UIImage(data: imageData)
//            if let size = image?.size {
//                width = size.width
//                ratio = width! / size.height
//                didDownloadImage = true
//                print("image set")
//            }
//        }
//        task.resume()
//        }
//    }
    
    
    
    
    private mutating func fetchImage() {
//        sleep(2)
        if let url = imageURL {

            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents, url == self.imageURL {
                image = UIImage(data: imageData)
                if let size = image?.size {
                    width = size.width
                    ratio = width! / size.height
                    didDownloadImage = true
                    print("image set")
                }
            }
            }
        }
    
    
    init(url: URL) {
        self.imageURL = url
        self.fetchImage()
    }
}

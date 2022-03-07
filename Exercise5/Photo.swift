//
//  Photo.swift
//  Exercise5
//
//  Created by Oren Dinur on 07/03/2022.
//

import Foundation
import UIKit

struct Photo {
    
    private (set) var image: UIImage? {
        didSet {
            if let size = image?.size {
                width = size.width
                ratio = width! / size.height
            }
        }
    }
    
    var ratio: CGFloat?
    var width: CGFloat?
    
    private (set) var imageURL : URL? {
        didSet {
            image = nil
            self.fetchImage()
        }
    }
    
    private mutating func fetchImage() {
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents, url == self.imageURL {
                image = UIImage(data: imageData)
            }
        }
    }
    
    init(url: URL) {
        self.imageURL = url
    }
    
}

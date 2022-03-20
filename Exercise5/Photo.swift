//
//  Photo.swift
//  Exercise5
//
//  Created by Oren Dinur on 07/03/2022.
//

import Foundation
import UIKit

struct Photo: Codable {
    var image: Image
    var ratio: CGFloat
    
}

struct Image: Codable{
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }

    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        
        return image
    }
}


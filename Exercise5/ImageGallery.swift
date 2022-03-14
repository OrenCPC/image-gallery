//
//  ImageGallery.swift
//  Exercise5
//
//  Created by Oren Dinur on 13/03/2022.
//
import UIKit

import Foundation
class ImageGallery {
    
//    static var galleriesDict: Dictionary<String,URL> = {
//       let Sapce = [
//           "Cassini" : "https://ichef.bbci.co.uk/news/976/cpsprodpb/17419/production/_97775259_saturn.jpg",
//           "Earth" : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AEarth_Western_Hemisphere.jpg&psig=AOvVaw2FrZFSEfEHPvSJsen8dB9i&ust=1646140999673000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCOjV6Z6_ovYCFQAAAAAdAAAAABAD",
//           "Saturn" : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ALatest_Saturn_Portrait_(48725935576).jpg&psig=AOvVaw0uPnD0FEusmhTNeIGxOEMq&ust=1646141017109000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCMCHpKi_ovYCFQAAAAAdAAAAABAD"
//       ]
//       var urls = Dictionary<String,URL>()
//       for (key,value) in galleriesDict {
//           urls[key] = URL(string: value)
//       }
//       return urls
//   }()
    
    
    
//    var Space = [ "https://ichef.bbci.co.uk/news/976/cpsprodpb/17419/production/_97775259_saturn.jpg",
//         "https://cdn.vox-cdn.com/thumbor/S_2OnmKwFbURIsaY5R0gGR1B6Pk=/0x0:3000x2000/620x413/filters:focal(1300x741:1780x1221):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/56671157/cassini.0.jpg"
//                        ,
//            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLGheJOf1gtzua1PYb_Qnq5OWkaoaiMhdP3Q&usqp=CAU",
//            "https://www.esa.int/var/esa/storage/images/esa_multimedia/images/2004/06/saturn_orbit_insertion_manoeuvre2/17885286-2-eng-GB/Saturn_orbit_insertion_manoeuvre.jpg",
//            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJqmNdNdMDERRQZALWMNmZpFFXpJ5fRbjKAA&usqp=CAU"
//    ]
    
    var images : [Photo] = []
    var imagesURL = [URL?]()


    
    private func fetchImage(imageUrl: URL?) {
        if let url = imageUrl {
//            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents {
                    if let image = UIImage(data: imageData) {
                        let imageWidth = image.size.width
                        let imageHeight = image.size.height
                        self.images += [Photo(image: image, ratio: imageWidth/imageHeight)]
                    }
//                }
            }
        }
    }

    private func fetchImages(onComplete: () -> Void) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3

        for index in 0..<imagesURL.count {

            let op1 = BlockOperation(block: {
                self.fetchImage(imageUrl: self.imagesURL[index]!)
            })

            queue.addOperation(op1)
        }
        queue.waitUntilAllOperationsAreFinished()
        onComplete()
    }
    

    
    
    
    func getImages(galleryName: String, onComplete: ([Photo]) -> Void) {
        self.imagesURL = galleryName.compactMap{ URL(string: $0) }
        self.images = []

        fetchImages {
            onComplete(images)
        }
    }
}

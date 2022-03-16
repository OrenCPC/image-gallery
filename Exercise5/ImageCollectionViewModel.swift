//
//  ImageGallery.swift
//  Exercise5
//
//  Created by Oren Dinur on 13/03/2022.
//
import UIKit

import Foundation
class ImageCollectionViewModel {
    
    var images : [Photo] = []
    
//    var currentGallery: ImageGallery = ImageGallery()
    
    private func fetchImage(imageUrl: URL?) {
        if let url = imageUrl?.imageURL {
            //            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                if let image = UIImage(data: imageData) {
                    let imageWidth = image.size.width
                    let imageHeight = image.size.height
                    self.images += [Photo(image: image, ratio: imageWidth/imageHeight)]
                }
            }
        }
    }

    private func fetchImages(gallery: ImageGallery ,onComplete: () -> Void) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3

        for index in 0..<gallery.imagesURL.count {

            let op1 = BlockOperation(block: {
                self.fetchImage(imageUrl: gallery.imagesURL[index]!)
            })

            queue.addOperation(op1)
        }
        queue.waitUntilAllOperationsAreFinished()
        onComplete()
    }
    
    func getImages(gallery: ImageGallery, onComplete: ([Photo]) -> Void) {
//        self.galleryNameModel = galleryName!
//        if let galleryValidName = dict[galleryNameModel] {
//            var allImagesUrl = galleryValidName.compactMap{ URL(string: $0) }
//            for _ in 0...1 {
//                if let randomElement = allImagesUrl.randomElement() {
//                    if let index = allImagesUrl.firstIndex(of: randomElement) {
//                        allImagesUrl.remove(at: index) // array is now ["world"]
//                        self.imagesURL += [randomElement]
//                    }
//                }
//            }
//        }
//        self.images = []
        ///Delete all above
        
//        self.currentGallery = gallery!
        fetchImages(gallery: gallery) {
            onComplete(images)
        }
    }
}

//
//  ImageGallery.swift
//  Exercise5
//
//  Created by Oren Dinur on 13/03/2022.
//
import UIKit

import Foundation
class ImageGallery {
    
    var dict = [ "Space" : ["https://ichef.bbci.co.uk/news/976/cpsprodpb/17419/production/_97775259_saturn.jpg",
                            "https://cdn.vox-cdn.com/thumbor/S_2OnmKwFbURIsaY5R0gGR1B6Pk=/0x0:3000x2000/620x413/filters:focal(1300x741:1780x1221):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/56671157/cassini.0.jpg",
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLGheJOf1gtzua1PYb_Qnq5OWkaoaiMhdP3Q&usqp=CAU",
                            "https://www.esa.int/var/esa/storage/images/esa_multimedia/images/2004/06/saturn_orbit_insertion_manoeuvre2/17885286-2-eng-GB/Saturn_orbit_insertion_manoeuvre.jpg",
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJqmNdNdMDERRQZALWMNmZpFFXpJ5fRbjKAA&usqp=CAU"],
                 "World" : ["https://media.nomadicmatt.com/moroccoguide.jpg",
                            "https://images.ctfassets.net/bth3mlrehms2/4yLP1lDOBZmvs9QVurVR1p/bdd664f68e0c155aafdc3ff14ceb6742/Mexiko_Mexico_City_Palacio_de_Bellas_Artes.jpg?w=750&h=422&fl=progressive&q=50&fm=jpg",
                            "https://idsb.tmgrup.com.tr/ly/uploads/images/2021/09/24/146502.jpg",
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6IKLMtIz6CbPldY2rADJjIYvCh_Rw-OfTuQ&usqp=CAU",
                            "https://i.natgeofe.com/n/c864cd91-f26b-4db5-bd62-3e97dc7358c9/temple-mount-jerusalem-israel_3x4.jpg",
                            "https://cms.finnair.com/resource/blob/673478/e5b938b6188640b6fe0d18442f66229e/melbourne-main-data.jpg"
                           ]
    ]
    
    var images : [Photo] = []
    var imagesURL = [URL?]()
    var galleryNameModel : String = ""


    
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
    
    func getImages(galleryName: String?, onComplete: ([Photo]) -> Void) {
        self.galleryNameModel = galleryName!
        if let galleryValidName = dict[galleryNameModel] {
            var allImagesUrl = galleryValidName.compactMap{ URL(string: $0) }
            for _ in 0...1 {
                if let randomElement = allImagesUrl.randomElement() {
                    if let index = allImagesUrl.firstIndex(of: randomElement) {
                        allImagesUrl.remove(at: index) // array is now ["world"]
                        self.imagesURL += [randomElement]
                    }
                }
            }
        }
        self.images = []
        fetchImages {
            onComplete(images)
        }
    }
}

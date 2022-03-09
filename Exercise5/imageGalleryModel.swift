//
//  imageGalleryModel.swift
//  Exercise5
//
//  Created by Oren Dinur on 08/03/2022.
//

import Foundation

struct imageGalleryModel {
    
    var photos : [Photo] = []
//    private let accessQueue = DispatchQueue(label: "SynchronizedArrayAccess", attributes: .concurrent)

    
    init (urls: [URL]) {
        for i in 0..<urls.count {

                let photo = Photo(url: urls[i])
                self.photos += [photo]
        }
    }
}

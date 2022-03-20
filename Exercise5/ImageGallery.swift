//
//  ImageGallery.swift
//  Exercise5
//
//  Created by Oren Dinur on 16/03/2022.
//

import Foundation

struct ImageGallery: Codable {

    var images : [Photo]
    var imagesURL : [URL?]
    var galleryName : String
    var identifier: Int
    var isDeleted: Bool
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(imagesURL: [URL?], galleryName: String) {
        self.identifier = ImageGallery.getUniqueIdentifier()
        self.imagesURL = imagesURL
        self.galleryName = galleryName
        self.images = []
        self.isDeleted = false
    }
}

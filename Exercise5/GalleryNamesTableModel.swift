//
//  GalleryNamesTableModel.swift
//  Exercise5
//
//  Created by Oren Dinur on 14/03/2022.
//

import Foundation
struct GalleryNamesTableModel {
        
//    var data = GalleryTableStorage(imageGalleryDocuments: ["Space"], recentlyDeletedImages: [])
    
    var data : Array<Section> = []
    
//    var imageGalleryDocuments = ["Space"]
//    var recentlyDeletedImages : [String] = []
//    var titles = ["Section A", "Recently Deleted"]
    
//    func title(at section: Int) -> String {
//        return titles[section]
//    }
    
    init() {
        data += [Section(sectionName: "imageGalleryDocuments", sectionGalleries: ["Space","World"]), Section(sectionName: "recentlyDeletedImages", sectionGalleries: [])]
    }
}

//
//  GalleryNamesTableModel.swift
//  Exercise5
//
//  Created by Oren Dinur on 14/03/2022.
//

import Foundation
struct GalleryNamesTableModel {
    
    var imageGalleries : [ImageGallery] = []
    var deletedImageGalleries: [ImageGallery] = []
    
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
    
//    var dictForNewGalleries = [ "images" : ["https://cdn.vox-cdn.com/thumbor/3X87MbCapoDX9oPTxX6Ab8Kuti0=/0x0:5472x3648/1200x675/filters:focal(2299x1387:3173x2261)/cdn.vox-cdn.com/uploads/chorus_image/image/69115492/GettyImages_1231075827.0.jpg",
//                                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlIAJelOgwRkZmg7muy4RD-oVv1zu8nfbIyA&usqp=CAU",
//                                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPlpFrXi-VKusNFLz3AuE2KuTTwRpQr8OGUQ&usqp=CAU"
//                                          ]]
//
//    var data : Array<Section> = []
    
//    mutating func addRow(at indexPath: IndexPath, with text: String) {
//        self.data[indexPath.section].sectionGalleries?[indexPath.row] = text
//    }
//    
//    func getRow(at indexPath: IndexPath) -> String? {
//        return self.data[indexPath.section].sectionGalleries?[indexPath.row]
//    }

    init() {
        for (name, stringUrls) in dict {
            let urls = stringUrls.compactMap{ URL(string: $0) }
            self.imageGalleries += [ImageGallery(imagesURL: urls, galleryName: name)]
        }
        
        /////Needs to be deleted
//        data += [Section(sectionName: "imageGalleryDocuments", sectionGalleries: [])]
//        for index in 0..<imageGalleries.count {
//            data[0].sectionGalleries! += [imageGalleries[index].galleryName]
//        }
//        data += [Section(sectionName: "recentlyDeletedImages", sectionGalleries: [])]
    }
}

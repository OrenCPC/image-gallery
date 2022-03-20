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
    
    var randomUrls =   ["https://i.natgeofe.com/k/75ac774d-e6c7-44fa-b787-d0e20742f797/giant-panda-eating_16x9.jpg",
                                 "https://a-z-animals.com/media/2021/01/Wild-Chameleon-Reptile-With-Beautiful-Colors-400x300.jpg",
                                 "https://i.natgeofe.com/k/c02b35d2-bfd7-4ed9-aad4-8e25627cd481/komodo-dragon-head-on_2x1.jpg",
                        "https://media.gadventures.com/media-server/cache/2d/c6/2dc661088449cb78e02345d8c261e8b1.jpg",
                        "https://smashinghub.com/wp-content/uploads/2010/07/wave8.jpg",
                        "https://clicklovegrow.com/wp-content/uploads/2020/01/Leeza-Wishart-Graduaste.jpg"
                                ]
    
    mutating func createNewGallery() {
        var urls : [String] = []
        var copyOfRandomUrls = randomUrls
        for _ in 0...1 {
            let randomUrlIndex = Int(arc4random_uniform(UInt32(randomUrls.count - 1)))
            urls += [copyOfRandomUrls.remove(at: randomUrlIndex)]
        }
        let newImageGallery = ImageGallery(imagesURL: urls.compactMap{ URL(string: $0) },
                                           galleryName: "Untitled".madeUnique(withRespectTo:
                                                                                (imageGalleries.map{ $0.galleryName})+(deletedImageGalleries.map{ $0.galleryName })))
        
        
        imageGalleries += [newImageGallery]
        
        saveGalleriesInDefaults()
    }
    
    mutating func deleteFromImageGallery(at indexPath: IndexPath)-> ImageGallery{
        let deletedGallery = imageGalleries.remove(at: indexPath.row)
        saveGalleriesInDefaults()
       return deletedGallery
    }
    
    mutating func deleteFromDeletedImageGallery(at indexPath: IndexPath)-> ImageGallery{
        let deletedGallery = deletedImageGalleries.remove(at: indexPath.row)
        saveDeletedGalleriesInDefaults()
       return deletedGallery
    }
    
    
    mutating func addToDeletedGallery(gallery: ImageGallery) {
        deletedImageGalleries += [gallery]
        saveDeletedGalleriesInDefaults()

    }
    
    mutating func addToImageGallery(gallery: ImageGallery) {
        imageGalleries += [gallery]
        saveGalleriesInDefaults()

    }
//    
//    func getRow(at indexPath: IndexPath) -> String? {
//        return self.data[indexPath.section].sectionGalleries?[indexPath.row]
//    }
    
    func saveGalleriesInDefaults() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(imageGalleries)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "image galleries")

        } catch {
            print("Unable to Encode Array of Image Galleries (\(error))")
        }
    }
    
    func saveDeletedGalleriesInDefaults() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(deletedImageGalleries)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "deleted image galleries")

        } catch {
            print("Unable to Encode deleted Array of Image Galleries (\(error))")
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "image galleries") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                imageGalleries = try decoder.decode([ImageGallery].self, from: data)

            } catch {
                print("Unable to Decode Array of Image galleries (\(error))")
            }
        } else {
            for (name, stringUrls) in dict {
                let urls = stringUrls.compactMap{ URL(string: $0) }
                let newImageGallery = ImageGallery(imagesURL: urls, galleryName: name)
                self.imageGalleries += [newImageGallery]
                saveGalleriesInDefaults()
            }
        }
        
        if let data = UserDefaults.standard.data(forKey: "deleted image galleries") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                deletedImageGalleries = try decoder.decode([ImageGallery].self, from: data)

            } catch {
                print("Unable to Decode Deleted Array of Image galleries (\(error))")
            }
        }
    }
}

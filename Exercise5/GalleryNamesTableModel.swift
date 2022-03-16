//
//  GalleryNamesTableModel.swift
//  Exercise5
//
//  Created by Oren Dinur on 14/03/2022.
//

import Foundation
struct GalleryNamesTableModel {
    
    var data : Array<Section> = []
    
//   mutating func deleteRow(at indexPath: IndexPath) {
//       let deletedRow = self.data[indexPath.section].sectionGalleries?.remove(at: indexPath.row)
//
//       switch self.data[indexPath.section].sectionName {
//            case "imageGalleryDocuments":
//            data[1].sectionGalleries! += [deletedRow!]
//            //Add to recently deleted
//            default:
//            //Do nothing
//            break
//        }
//    }
    
    mutating func addRow(at indexPath: IndexPath, with text: String) {
        self.data[indexPath.section].sectionGalleries?[indexPath.row] = text
    }
    
    func getRow(at indexPath: IndexPath) -> String? {
        return self.data[indexPath.section].sectionGalleries?[indexPath.row]
        
    }
    
    

    init() {
        data += [Section(sectionName: "imageGalleryDocuments", sectionGalleries: ["Space","World"]),
                 Section(sectionName: "recentlyDeletedImages", sectionGalleries: [])]
    }
}

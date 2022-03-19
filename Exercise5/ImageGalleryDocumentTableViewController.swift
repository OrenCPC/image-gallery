//
//  ImageGalleryDocumentTableViewController.swift
//  Exercise5
//
//  Created by Oren Dinur on 02/03/2022.
//

import UIKit

class ImageGalleryDocumentTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
     lazy var tableModel = GalleryNamesTableModel()
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
   override func shouldPerformSegue(withIdentifier identifier: String,
                                         sender: Any?) -> Bool {
       switch identifier {
       case "TableToGallery" :
           if let cell = sender as? UITableViewCell,
              
               let indexPath = tableView.indexPath(for: cell) {
               if indexPath.section == 0 {
                   return true
               }
           }
       default: break
       }
       return false
   }
   
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let identifier = segue.identifier {
           if shouldPerformSegue(withIdentifier: identifier, sender: sender as? UITableViewCell) {
               switch identifier {
               case "TableToGallery" :
                   if let cell = sender as? UITableViewCell,
                      let indexPath = tableView.indexPath(for: cell),
                      let seguedToMVC = segue.destination as? ImageGalleryCollectionViewController {
                       seguedToMVC.galleryWithoutImages = tableModel.imageGalleries[indexPath.row]
                   }
               default: break
               }
           }
       }
   }
    
    @objc func singleTapFunc(inputCell: MyTableViewCell) {
//        let cell = self
       performSegue(withIdentifier: "TableToGallery", sender: self)
   }
   
   @objc func doubleTapFunc(inputCell: MyTableViewCell) {
       inputCell.textField.isEnabled = true
       inputCell.textField.clearsOnBeginEditing = true
   }
    
    
    
    // MARK: - Table view data source

    @IBAction func newImageGallery(_ sender: UIBarButtonItem) {
        tableModel.createNewGallery()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Image Galleries"
        case 1: return "Recently Deleted Image Galleries"
        default: return ""
       }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return tableModel.imageGalleries.count
        case 1: return tableModel.deletedImageGalleries.count
        default: return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
        // Configure the cell...
        
        if let inputCell = cell as? MyTableViewCell {
            switch indexPath.section {
            case 0: inputCell.textField.text = tableModel.imageGalleries[indexPath.row].galleryName
            case 1: inputCell.textField.text = tableModel.deletedImageGalleries[indexPath.row].galleryName
                
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapFunc))
                        doubleTap.numberOfTapsRequired = 2
                self.tableView.addGestureRecognizer(doubleTap)
                
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapFunc))
                        singleTap.numberOfTapsRequired = 1
                self.tableView.addGestureRecognizer(singleTap)
                
            default: break
                
            }
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 40
    }
         
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 40
    }
    

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableModel.deleteRow(at: indexPath)
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
//
//            tableView.reloadData()
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            switch indexPath.section {
                
            case 0:
                let deletedGallery = tableModel.deleteFromImageGallery(at: indexPath)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableModel.addToDeletedGallery(gallery: deletedGallery)
                
            case 1:
                tableModel.deleteFromDeletedImageGallery(at: indexPath)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            default: break
            }
            tableView.reloadData()
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView,
                                         leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                let action = UIContextualAction(style: .normal, title: title,
                    handler: { (action, view, completionHandler) in
                    
                    switch indexPath.section {
                        
                    case 0:break
                        
                    case 1:
                        let deletedRow = self.tableModel.deleteFromDeletedImageGallery(at: indexPath)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        self.tableModel.addToImageGallery(gallery: deletedRow)

                    default: break
                    }
                    completionHandler(true)
                    tableView.reloadData()
                    
                  })
                let configuration = UISwipeActionsConfiguration(actions: [action])
                return configuration
        }
    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableModel.deleteRow(at: indexPath)
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
//
//            tableView.reloadData()
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Collection {
    func count(where test: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(test).count
    }
}

//
//  ImageGalleryDocumentTableViewController.swift
//  Exercise5
//
//  Created by Oren Dinur on 02/03/2022.
//

import UIKit

class ImageGalleryDocumentTableViewController: UITableViewController {
    
    private lazy var tableModel = GalleryNamesTableModel()
    
    let imageGalleriesSection = 0
    
    let deletedImageGalleriesSection = 1
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
                switch identifier {
                case "TableToGallery" :
                    if let cell = sender as? UITableViewCell,
                       let indexPath = tableView.indexPath(for: cell),
                       let seguedToMVC = segue.destination as? ImageGalleryCollectionViewController {
                        seguedToMVC.galleryWithoutImages = tableModel.imageGalleries[indexPath.row]
                        seguedToMVC.title = tableModel.imageGalleries[indexPath.row].galleryName
                    }
                default: break
                }
        }
    }
    
    // MARK: - Table view data source

    @IBAction func newImageGallery(_ sender: UIBarButtonItem) {
        tableModel.createNewGallery()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case imageGalleriesSection: return "Image Galleries"
        case deletedImageGalleriesSection: return "Recently Deleted Image Galleries"
        default: return ""
       }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case imageGalleriesSection: return tableModel.imageGalleries.count
        case deletedImageGalleriesSection: return tableModel.deletedImageGalleries.count
        default: return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
        // Configure the cell...
        
        if let inputCell = cell as? MyTableViewCell {
            switch indexPath.section {
            case imageGalleriesSection: inputCell.textField.text = tableModel.imageGalleries[indexPath.row].galleryName
            case deletedImageGalleriesSection: inputCell.textField.text = tableModel.deletedImageGalleries[indexPath.row].galleryName
            default: break
            }
            inputCell.resignationHandler = { [weak self, unowned inputCell] in
                if let text = inputCell.textField.text {
                    switch indexPath.section {
                    case self?.imageGalleriesSection:
                        self?.tableModel.imageGalleries[indexPath.row].galleryName = text
                        self?.tableModel.saveGalleriesInDefaults()
                        
                    case self?.deletedImageGalleriesSection:
                        self?.tableModel.deletedImageGalleries[indexPath.row].galleryName = text
                        self?.tableModel.saveDeletedGalleriesInDefaults()
                    default: break
                    }
                }
                self?.tableView.reloadData()
            }
            
            inputCell.segueHandler = { [weak self, unowned inputCell] in
                if indexPath.section == self?.imageGalleriesSection {
                self?.performSegue(withIdentifier: "TableToGallery", sender: inputCell)
                }
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


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            switch indexPath.section {
                
            case imageGalleriesSection:
                let deletedGallery = tableModel.deleteFromImageGallery(at: indexPath)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableModel.addToDeletedGallery(gallery: deletedGallery)
                
            case deletedImageGalleriesSection:
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
                    
                    if indexPath.section == self.deletedImageGalleriesSection {
                        let deletedRow = self.tableModel.deleteFromDeletedImageGallery(at: indexPath)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        self.tableModel.addToImageGallery(gallery: deletedRow)
                    }
                    
                    completionHandler(true)
                    tableView.reloadData()
                    
                  })
                let configuration = UISwipeActionsConfiguration(actions: [action])
                return configuration
        }
}


extension Collection {
    func count(where test: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(test).count
    }
}

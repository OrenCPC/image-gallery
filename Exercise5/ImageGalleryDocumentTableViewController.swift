//
//  ImageGalleryDocumentTableViewController.swift
//  Exercise5
//
//  Created by Oren Dinur on 02/03/2022.
//

import UIKit

class ImageGalleryDocumentTableViewController: UITableViewController {
    
//    @IBAction func newImageGallery(_ sender: UIBarButtonItem) {
//        imageGalleryDocuments += ["Untitled".madeUnique(withRespectTo: imageGalleryDocuments)]
//        tableView.reloadData()
//    }
    
    private lazy var tableModel = GalleryNamesTableModel()

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Space" :
                if let cell = sender as? UITableViewCell,
                   let indexPath = tableView.indexPath(for: cell),
                   let seguedToMVC = segue.destination as? ImageGalleryCollectionViewController {
                    seguedToMVC.galleryName = tableModel.data[indexPath.section].sectionGalleries?[indexPath.row]
                }
            default: break
            }
        }
    }
    
    // MARK: - Table view data source

    
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return tableModel.title(at: section)
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
//        view.backgroundColor = UIColor.red
             
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.text = tableModel.data[section].sectionName
        view.addSubview(lbl)
           return view
         }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableModel.data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return tableModel.data[section].sectionGalleries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = tableModel.data[indexPath.section].sectionGalleries?[indexPath.row]

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

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            var deletedRow = tableModel.data[indexPath.section].sectionGalleries?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            switch tableModel.data[indexPath.section].sectionName {
                case "imageGalleryDocuments":
                tableModel.data[indexPath.section + 1].sectionGalleries! += [deletedRow!]
                //Add to recently deleted

                default:
                //Do nothing
                break
            }
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

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

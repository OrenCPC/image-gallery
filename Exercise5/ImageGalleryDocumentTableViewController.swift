//
//  ImageGalleryDocumentTableViewController.swift
//  Exercise5
//
//  Created by Oren Dinur on 02/03/2022.
//

import UIKit

class ImageGalleryDocumentTableViewController: UITableViewController {
    

    
    private lazy var tableModel = GalleryNamesTableModel()

    
    override func shouldPerformSegue(withIdentifier identifier: String,
                                          sender: Any?) -> Bool {
        switch identifier {
        case "Space" :
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
    }
    
    // MARK: - Table view data source

    @IBAction func newImageGallery(_ sender: UIBarButtonItem) {
        tableModel.data[0].sectionGalleries! += ["Untitled".madeUnique(withRespectTo: tableModel.data[0].sectionGalleries!)]
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
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
    
    func updateCollectionViewFromTableView() {
//        let listOfGalleries = 
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)

        // Configure the cell...
        if let inputCell = cell as? MyTableViewCell {
            inputCell.resignationHandler = { [weak self, unowned inputCell] in
                if let text = inputCell.textField.text {
                    self?.tableModel.data[indexPath.section].sectionGalleries?[indexPath.row] = text
                }
                self?.updateCollectionViewFromTableView()
                self?.tableView.reloadData()
                
            }
        }
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

    override func tableView(_ tableView: UITableView,
                                     leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .normal, title: title,
                handler: { (action, view, completionHandler) in
                
                let deletedRow = self.tableModel.data[indexPath.section].sectionGalleries?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                self.tableModel.data[0].sectionGalleries! += [deletedRow!]
                
                // Update data source when user taps action
//                self.dataSource?.setFavorite(!favorite, at: indexPath)
                completionHandler(true)
                tableView.reloadData()
                
              })
            let configuration = UISwipeActionsConfiguration(actions: [action])
//        tableView.reloadData()
            return configuration
        
        
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let deletedRow = tableModel.data[indexPath.section].sectionGalleries?.remove(at: indexPath.row)
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

//
//  MyTableViewCell.swift
//  Exercise5
//
//  Created by Oren Dinur on 15/03/2022.
//

import UIKit

class MyTableViewCell: UITableViewCell, UITextFieldDelegate {

    private lazy var myTableView = ImageGalleryDocumentTableViewController()

    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.isEnabled = false
        }
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        textField.isEnabled = false

        return true
    }
    
    var resignationHandler: (() -> Void)?
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        resignationHandler?()
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.clearsOnBeginEditing = true
//
//    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    
     
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

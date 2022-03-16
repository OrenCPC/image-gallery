//
//  MyTableViewCell.swift
//  Exercise5
//
//  Created by Oren Dinur on 15/03/2022.
//

import UIKit

class MyTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField! {
        didSet {

            textField.delegate = self
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
    
    
    @objc func doubleTapFunc() {
        textField.clearsOnBeginEditing = true
        textField.isEnabled = true

        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

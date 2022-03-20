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
        textField.isEnabled = false
        return true
    }

    var resignationHandler: (() -> Void)?
    
    var segueHandler: (() -> Void)?

    func textFieldDidEndEditing(_ textField: UITextField) {
        resignationHandler?()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapFunc))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapFunc))
        singleTap.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTap)
        singleTap.require(toFail: doubleTap)

        
        textField.isEnabled = false

    }
    
    @objc func singleTapFunc() {
        print("single")

        textField.isEnabled = false
        segueHandler?()
    }
    
    @objc func doubleTapFunc() {
        print("double")
        textField.isEnabled = true
        textField.becomeFirstResponder()

    }
}

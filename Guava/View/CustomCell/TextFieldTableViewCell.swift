//
//  TextFieldTableViewCell.swift
//  Guava
//
//  Created by Marko Budal on 04/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

enum TextFieldType {
    case EmailType
    case PassowrdType
}
class TextFieldTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(placeholderText:String, fieldType: TextFieldType) {
        textField.delegate = self
        textField.placeholder = placeholderText
        switch (fieldType) {
            case .EmailType:
                textField.keyboardType = .EmailAddress
            break
            case .PassowrdType:
                textField.secureTextEntry = true
            break
        }
    }
    
    //MARK: TextField Delegate 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

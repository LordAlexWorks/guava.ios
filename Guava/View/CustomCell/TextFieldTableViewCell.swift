//
//  TextFieldTableViewCell.swift
//  Guava
//
//  Created by Marko Budal on 04/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(placeholderText:String) {
        textField.text = placeholderText
    }
    
    func setup(placeholderText:String, textFontWeight: FontWeight, textSize: CGFloat) {
        textField.placeholder = placeholderText
        textField.font = UIFont.avenir(textFontWeight, size: textSize)
    }
    
}

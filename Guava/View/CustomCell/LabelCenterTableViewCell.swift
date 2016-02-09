//
//  LabelCenterTableViewCell.swift
//  Guava
//
//  Created by Marko Budal on 04/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class LabelCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var centerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(labelName: String, sizeLabel: CGFloat){
        self.centerLabel.text = labelName
        self.centerLabel.font = UIFont(name: "Helvetica", size: sizeLabel)
<<<<<<< HEAD
=======
    }
    
    func setup(labelName: String, textFontWeight: FontWeight, textSize: CGFloat) {
        self.centerLabel.text = labelName
        self.centerLabel.font = UIFont.avenir(textFontWeight, size: textSize)
>>>>>>> master
    }
    
    func setup(labelName: String, textFontWeight: FontWeight, textSize: CGFloat) {
        self.centerLabel.text = labelName
        self.centerLabel.font = UIFont.avenir(textFontWeight, size: textSize)
    }

}

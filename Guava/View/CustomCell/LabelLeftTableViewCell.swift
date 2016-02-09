//
//  LabelLeftTableViewCell.swift
//  Guava
//
//  Created by Marko Budal on 04/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class LabelLeftTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(labelName: String){
        self.leftLabel.text = labelName
        self.leftLabel.font = UIFont(name: "Helvetica", size: 12)
    }
    
    func setup(labelName: String, textFontWeight: FontWeight, textSize: CGFloat) {
        leftLabel.text = labelName
        leftLabel.font = UIFont.avenir(textFontWeight, size: textSize)
    }
    
    func setup(labelName: String, textFontWeight: FontWeight, textSize: CGFloat) {
        leftLabel.text = labelName
        leftLabel.font = UIFont.avenir(textFontWeight, size: textSize)
    }
}

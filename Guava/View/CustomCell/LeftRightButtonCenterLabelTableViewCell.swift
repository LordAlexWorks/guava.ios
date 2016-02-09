//
//  LeftRightButtonCenterLabelTableViewCell.swift
//  Guava
//
//  Created by Marko Budal on 05/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

protocol LeftRightButtonDelegate {
    func leftTopButton(sender: UIButton)
    func rightTopButton(sender: UIButton)
}

class LeftRightButtonCenterLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var delegate: LeftRightButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(centerLabelText: String, delegate: LeftRightButtonDelegate) {
        centerLabel.text = centerLabelText
        self.delegate = delegate
    }
    
    @IBAction func leftButtonTapped(sender: UIButton) {
        delegate?.leftTopButton(sender)
    }
    
    @IBAction func rightButtonTapped(sender: UIButton) {
        delegate?.rightTopButton(sender)
    }
}

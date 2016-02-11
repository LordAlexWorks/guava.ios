//
//  ButtonCenterTableViewCell.swift
//  Guava
//
//  Created by Marko Budal on 04/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

enum ButtonType: String {
    case LOG = "log"
    case FB = "facebook"
    case TWITTER = "twitter"
}

protocol ButtonCenterTableViewDelegate {
    func loginButtonTapped()
}

class ButtonCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonCenter: UIButton!
    var delegate: ButtonCenterTableViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(buttonTitle: String, buttonType: ButtonType, textFontWeight: FontWeight, textSize: CGFloat, delegate:ButtonCenterTableViewDelegate) {

        self.delegate = delegate
        buttonCenter.setTitle(buttonTitle, forState: .Normal)
        buttonCenter.titleLabel?.font = UIFont.avenir(textFontWeight, size: textSize)
        buttonCenter.layer.cornerRadius = 28
        buttonCenter.layer.borderWidth = 1
        
        switch buttonType {
            case .LOG:
                buttonCenter.setTitleColor(.whiteColor(), forState: .Normal)
                buttonCenter.backgroundColor = UIColor.clearColor()
                buttonCenter.layer.borderColor = UIColor.whiteColor().CGColor
            case .FB:
                buttonCenter.setTitleColor(.whiteColor(), forState: .Normal)
                buttonCenter.backgroundColor = UIColor.facebookColor()
                buttonCenter.layer.borderColor = UIColor.facebookColor().CGColor
            case .TWITTER:
                buttonCenter.setTitleColor(.whiteColor(), forState: .Normal)
                buttonCenter.backgroundColor = UIColor.twitterColor()
                buttonCenter.layer.borderColor = UIColor.twitterColor().CGColor

        }

    }
    @IBAction func loginButtonTapped(sender: UIButton) {
        delegate?.loginButtonTapped()
    }
}

//
//  SignInTableViewCell.swift
//  Guava
//
//  Created by Marko Budal on 04/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

protocol SignInTableViewDelegate {
    func signInButtonTapped(sender: UIButton)
}

class SignInTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    var delegate: SignInTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(buttonText: String, delegate: SignInTableViewDelegate) {
        button.setTitle(buttonText, forState: .Normal)
        self.delegate = delegate
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        delegate?.signInButtonTapped(sender)
    }
}

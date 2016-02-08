//
//  UITableExtension.swift
//  Guava
//
//  Created by Marko Budal on 04/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

enum CustomCell:String {
    case SignIn = "SignInTableViewCell"
    case CenterLabel = "LabelCenterTableViewCell"
    case LeftLabel = "LabelLeftTableViewCell"
    case TextField = "TextFieldTableViewCell"
    case ButtonCenter = "ButtonCenterTableViewCell"
    case LeftRightButtonCenterLabel = "LeftRightButtonCenterLabelTableViewCell"
}

extension UITableView {
    
    func registerCustomCellNib(nibName:String, cellReuseIdentifier:String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.registerNib(nib, forCellReuseIdentifier:cellReuseIdentifier)
    }
    
    func addNib(cell:CustomCell) {
        registerCustomCellNib(cell.rawValue, cellReuseIdentifier:cell.rawValue)
        
    }
}
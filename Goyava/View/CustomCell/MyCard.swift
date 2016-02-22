//
//  MyCard.swift
//  Guava
//
//  Created by Susim Samanta on 10/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class MyCard: UIView {
    
    @IBOutlet weak var iconImageView :  UIImageView!
    @IBOutlet weak var globalPointLabel : UILabel!
    @IBOutlet weak var weeklyPointLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MyCard", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func refreshUIWithDatasource(){
        CircleView.drawCircleOn(self)
    }
    override func layoutSubviews(){
        if iconImageView != nil {
            iconImageView.frame = CGRect(x: 10, y: 14, width: frame.size.width-30, height: frame.size.height-48)
            globalPointLabel.frame = CGRect(x: 0, y: frame.size.height-35, width: frame.size.width, height: 15)
            weeklyPointLabel.frame = CGRect(x: 0, y: frame.size.height-20, width: frame.size.width, height: 10)
        }

    }
}

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
    @IBOutlet weak var backgroundCicularview : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MyCard", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }

    override func layoutSubviews(){
        if iconImageView != nil {
            print(frame)
            backgroundCicularview.frame = CGRect(x: (frame.size.width-frame.size.height)/2+5, y: 0, width: frame.size.height-35, height: frame.size.height-35)
            globalPointLabel.frame = CGRect(x: 0, y: frame.size.height-35, width: frame.size.width, height: 15)
            weeklyPointLabel.frame = CGRect(x: 0, y: frame.size.height-20, width: frame.size.width, height: 10)
            CircleView.drawCircleOn(backgroundCicularview, color: UIColor.grayColor(), progress:2)
            CircleView.drawCircleOn(backgroundCicularview, color: UIColor(hexString:"29ABA9"), progress:1)

            iconImageView.frame = CGRect(x: (frame.size.width-frame.size.height)/2+32, y: 20, width: frame.size.height-65, height: frame.size.height-65)
        }

    }
}

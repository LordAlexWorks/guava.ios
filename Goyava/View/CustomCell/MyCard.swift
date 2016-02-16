//
//  MyCard.swift
//  Guava
//
//  Created by Susim Samanta on 10/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class MyCard: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView :  UIImageView!
    @IBOutlet weak var globalPointLabel : UILabel!
    @IBOutlet weak var weeklyPointLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func refreshUIWithDatasource(){
        let circleView = CircleView(frame: CGRectMake(24, 2, 113,113))
        self.addSubview(circleView)
    }

}

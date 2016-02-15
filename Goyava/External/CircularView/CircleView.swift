//
//  CircleView.swift
//  SSCircle
//
//  Created by Susim Samanta on 15/02/16.
//  Copyright © 2016 Susim Samanta. All rights reserved.
//

import UIKit

class CircleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("Fatal Error!")
    }
    
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 5.0);
        UIColor.redColor().set()
        CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 1.5), 1)
        CGContextStrokePath(context);
    }
}

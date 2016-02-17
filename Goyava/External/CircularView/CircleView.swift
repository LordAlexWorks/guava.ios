//
//  CircleView.swift
//  SSCircle
//
//  Created by Susim Samanta on 15/02/16.
//  Copyright © 2016 Susim Samanta. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    static func drawCircleOn(view : UIView){
        let circlePath = UIBezierPath(arcCenter: CGPointMake(view.center.x+18, view.center.y), radius: CGFloat(view.frame.width/2-5), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.greenColor().CGColor
        shapeLayer.lineWidth = 5.0
        view.layer.addSublayer(shapeLayer)
    }
}

//
//  CircleView.swift
//  SSCircle
//
//  Created by Susim Samanta on 15/02/16.
//  Copyright © 2016 Susim Samanta. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    static func drawCircleOn(_ view : UIView, color: UIColor, progress: Double,lineWidth : Double, fillColor :UIColor){
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.center.x+5, y: view.center.y+5), radius: CGFloat(view.frame.width/2-8), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * progress), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = CGFloat(lineWidth)
        view.layer.addSublayer(shapeLayer)
    }
}

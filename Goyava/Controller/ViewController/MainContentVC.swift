//
//  MainContentVC.swift
//  Goyava
//
//  Created by Susim Samanta on 15/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit


class MainContentVC: UIViewController {
    var pageIndex : Int = 0
    @IBOutlet weak var bottomConstraint : NSLayoutConstraint!
    @IBOutlet weak var mondayProgressView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showProgress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showProgress(){
        CircleView.drawCircleOn(mondayProgressView, color: UIColor.grayColor(), progress:2,lineWidth: 1.5,fillColor: UIColor.clearColor())
        CircleView.drawCircleOn(mondayProgressView, color: UIColor.redColor(), progress:1,lineWidth : 1.5,fillColor: UIColor.clearColor())
    }
    
}

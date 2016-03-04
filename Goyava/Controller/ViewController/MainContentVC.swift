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
    @IBOutlet weak var tuesdayProgressView : UIView!
    @IBOutlet weak var wednesdayProgressView : UIView!
    @IBOutlet weak var thrursdayProgressView : UIView!
    @IBOutlet weak var fridayProgressView : UIView!
    @IBOutlet weak var saturdayProgressView : UIView!
    @IBOutlet weak var sundayProgressView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showProgress(self.mondayProgressView)
        self.showProgress(self.tuesdayProgressView)
        self.showProgress(self.wednesdayProgressView)
        self.showProgress(self.thrursdayProgressView)
        self.showProgress(self.fridayProgressView)
        self.showProgress(self.saturdayProgressView)
        self.showProgress(self.sundayProgressView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showProgress(progressView : UIView){
        CircleView.drawCircleOn(progressView, color: UIColor.grayColor(), progress:2,lineWidth: 1.5,fillColor: UIColor.clearColor())
        CircleView.drawCircleOn(progressView, color: UIColor(hexString:"29ABA9"), progress:1,lineWidth : 1.5,fillColor: UIColor.clearColor())
    }
    
}

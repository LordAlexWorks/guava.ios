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
    @IBOutlet weak var weeklyProgressView : UIView!
    
    @IBOutlet weak var globalPointsLabel : UILabel!
    @IBOutlet weak var weeklyPointsLabel : UILabel!
    @IBOutlet weak var cardIconImageView : UIImageView!
    
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshUIWithDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: Data Source 
    func loadDataSource(card : Card) {
        self.card = card
    }
    func refreshUIWithDataSource(){
        self.progressControlSetups()
        self.globalPointsLabel.text = "\(ActivitiesController.getGlobalPoint(self.card!))"
        self.weeklyPointsLabel.text = "YOU HAVE SCORED \(ActivitiesController.getWeeklyPoint(self.card!)) POINTS THIS WEEK"
    }
    //MARK: Progress Controls 
    func progressControlSetups() {
        self.showProgress(self.mondayProgressView)
        self.showProgress(self.tuesdayProgressView)
        self.showProgress(self.wednesdayProgressView)
        self.showProgress(self.thrursdayProgressView)
        self.showProgress(self.fridayProgressView)
        self.showProgress(self.saturdayProgressView)
        self.showProgress(self.sundayProgressView)
        self.weeklyProgressView.frame = CGRectMake(1.5, -9, 175, 175);
        CircleView.drawCircleOn(self.weeklyProgressView, color: UIColor.grayColor(), progress:2,lineWidth: 10.0,fillColor: UIColor.clearColor())
        CircleView.drawCircleOn(self.weeklyProgressView, color: UIColor(hexString:"29ABA9"), progress:1,lineWidth : 10.0,fillColor: UIColor.clearColor())
        
    }
    func showProgress(progressView : UIView){
        CircleView.drawCircleOn(progressView, color: UIColor.grayColor(), progress:2,lineWidth: 1.5,fillColor: UIColor.clearColor())
        CircleView.drawCircleOn(progressView, color: UIColor(hexString:"29ABA9"), progress:1,lineWidth : 1.5,fillColor: UIColor.clearColor())
    }
    
}

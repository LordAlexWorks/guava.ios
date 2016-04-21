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
    
    @IBOutlet weak var mondayPointsLabel : UILabel!
    @IBOutlet weak var tuesdayPointsLabel : UILabel!
    @IBOutlet weak var wednesdayPointsLabel : UILabel!
    @IBOutlet weak var thrusdayPointsLabel : UILabel!
    @IBOutlet weak var fridayPointsLabel : UILabel!
    @IBOutlet weak var saturdayPointsLabel : UILabel!
    @IBOutlet weak var sundayPointsLabel : UILabel!
    
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
        self.setupDailyPoints()
        self.globalPointsLabel.text = "\(ActivitiesController.getGlobalPoint(self.card!))"
        self.weeklyPointsLabel.text = "YOU HAVE SCORED \(ActivitiesController.getWeeklyPoint(self.card!)) POINTS THIS WEEK"
    }
    //MARK: Progress Controls 
    func progressControlSetups() {
        self.showProgress(self.mondayProgressView, day: 1)
        self.showProgress(self.tuesdayProgressView, day: 2)
        self.showProgress(self.wednesdayProgressView, day: 3)
        self.showProgress(self.thrursdayProgressView, day: 4)
        self.showProgress(self.fridayProgressView, day: 5)
        self.showProgress(self.saturdayProgressView, day: 6)
        self.showProgress(self.sundayProgressView, day: 7)
        self.weeklyProgressView.frame = CGRectMake(0, 0, 170, 170);
        
        let globalPoints = Double(ActivitiesController.getGlobalPoint(self.card!))
        let weeklyPoints = Double(ActivitiesController.getWeeklyPoint(self.card!))
        let totalProgress = weeklyPoints/globalPoints
        CircleView.drawCircleOn(self.weeklyProgressView, color: UIColor.grayColor(), progress:2,lineWidth: 10.0,fillColor: UIColor.clearColor())
        CircleView.drawCircleOn(self.weeklyProgressView, color: UIColor(hexString:"29ABA9"), progress:totalProgress,lineWidth : 10.0,fillColor: UIColor.clearColor())
        
    }
    func showProgress(progressView : UIView, day:Double){
        let dailypoints = Double(ActivitiesController.getDailyTotalPointsOnDay(day, card: self.card!))
        let weeklyPoints = Double(ActivitiesController.getWeeklyPoint(self.card!))
        let progress = dailypoints/weeklyPoints
        CircleView.drawCircleOn(progressView, color: UIColor.grayColor(), progress:2,lineWidth: 1.5,fillColor: UIColor.clearColor())
        CircleView.drawCircleOn(progressView, color: UIColor(hexString:"29ABA9"), progress:progress,lineWidth : 1.5,fillColor: UIColor.clearColor())
    }
    //MARK: func DailyPoints set ups
    func setupDailyPoints(){
        self.mondayPointsLabel.text = "\(ActivitiesController.getDailyTotalPointsOnDay(1.0, card: self.card!))"
        self.tuesdayPointsLabel.text = "\(ActivitiesController.getDailyTotalPointsOnDay(2.0, card: self.card!))"
        self.wednesdayPointsLabel.text = "\(ActivitiesController.getDailyTotalPointsOnDay(3.0, card: self.card!))"
        self.thrusdayPointsLabel.text = "\(ActivitiesController.getDailyTotalPointsOnDay(4.0, card: self.card!))"
        self.fridayPointsLabel.text = "\(ActivitiesController.getDailyTotalPointsOnDay(5.0, card: self.card!))"
        self.saturdayPointsLabel.text = "\(ActivitiesController.getDailyTotalPointsOnDay(6.0, card: self.card!))"
        self.sundayPointsLabel.text = "\(ActivitiesController.getDailyTotalPointsOnDay(7.0, card: self.card!))"
        
    }
}

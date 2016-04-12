//
//  MyCardsVC.swift
//  Guava
//
//  Created by Susim Samanta on 10/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift



class MyCardsVC: UIViewController,UIPageViewControllerDataSource {
    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    var dataSource =  [List<Card>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDataSource()
        self.createMainPages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setUpUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
    }
    
    //MARK: Button Actions 
    @IBAction func scanButtonTapped(sender : UIButton) {
        goToScannerView()
    }
    @IBAction func logoutButtonTapped(sender : UIButton) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        self.dismissViewControllerAnimated(false) { () -> Void in
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let loginVc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
            appDelegate.window?.rootViewController = loginVc
        }
    }
    @IBAction func gridButtonTapped(sender : UIButton) {
        let mainVc = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! MainVC
        mainVc.modalTransitionStyle = .FlipHorizontal
        self.presentViewController(mainVc, animated: true) { () -> Void in
        }
        mainVc.onDismiss { [weak self]() -> Void in
            self?.goToScannerView()
        }
    }
  
    func createMainPages(){
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: MyCardContentVC = self.storyboard?.instantiateViewControllerWithIdentifier("MyCardContentVC") as! MyCardContentVC
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height-100);
        pageViewController?.view.backgroundColor = UIColor.clearColor()
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    func loadDataSource() {
        
        // process data with UI logic
        let realm = try! Realm()
        let user = realm.objects(User).first
        if user != nil {
            let mycards = user!.myCards
            if mycards.count%6 == 0 {
                var count = 0
                var internalCards = List<Card>()
                for item in mycards {
                    if count == 0 {
                        internalCards = List<Card>()
                    }
                    internalCards.append(item)
                    count += 1
                    if count == 6 {
                        count = 0
                        self.dataSource.append(internalCards)
                    }
                }
                
            }else {
                print("cards list does not have multiple of 6 cards")
            }
        }
    }
    //MARK: Page Control Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! MyCardContentVC).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        var index = (viewController as! MyCardContentVC).pageIndex
        if index == NSNotFound {
            return nil
        }
        index += 1
        if (index == self.dataSource.count) {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> MyCardContentVC? {
        if self.dataSource.count == 0 || index >= self.dataSource.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyCardContentVC") as! MyCardContentVC
        pageContentViewController.pageIndex = index
        currentIndex = index
        return pageContentViewController
    }
    //MARK: Scanner
    func goToScannerView(){
        let qrscannerVc = self.storyboard?.instantiateViewControllerWithIdentifier("QRScannerVC") as! QRScannerVC
        qrscannerVc.isAuthorizedForCamera { (isGranted) -> Void in
            if isGranted {
                self.presentViewController(qrscannerVc, animated: true) { () -> Void in
                }
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Guava need your camera access. Settings->Guava->Camera.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Cancel, handler:{ action in
                    UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
}

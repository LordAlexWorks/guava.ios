//
//  MyCardsVC.swift
//  Guava
//
//  Created by Susim Samanta on 10/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

typealias MyCardsCompletionHandler = () -> Void

class MyCardsVC: UIViewController,UIPageViewControllerDataSource {
    var myCardsHandler : MyCardsCompletionHandler?
    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = ["","",""]
        self.createMainPages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setUpUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
    }
    func onDismiss(handler : MyCardsCompletionHandler) {
        self.myCardsHandler = handler
    }
    //MARK: Button Actions 
    @IBAction func scanButtonTapped(sender : UIButton) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            self.myCardsHandler!()
        }
    }
    @IBAction func logoutButtonTapped(sender : UIButton) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let loginVc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
            appDelegate.window?.rootViewController = loginVc
        }
    }
    @IBAction func gridButtonTapped(sender : UIButton) {
        self.dismissViewControllerAnimated(true) { () -> Void in
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
    
}

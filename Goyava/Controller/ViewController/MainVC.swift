//
//  MainVC.swift
//  Goyava
//
//  Created by Susim Samanta on 15/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift

typealias MainCardsCompletionHandler = () -> Void

class MainVC: UIViewController,UIPageViewControllerDataSource {
    var mainCardsHandler : MainCardsCompletionHandler?
    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    var dataSource = List<Card>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.self.displayPage(self.currentIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func onDismiss(handler : MainCardsCompletionHandler) {
        self.mainCardsHandler = handler
    }
    func displayPage(atIndex : Int){
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: MainContentVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainContentVC") as! MainContentVC
        startingViewController.loadDataSource(self.dataSource[atIndex])
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 71, view.frame.size.width, view.frame.size.height-109);
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    func loadDataSource(card : Card) {
        // process data with UI logic
        let realm = try! Realm()
        let user = realm.objects(User).first
        if user != nil {
            self.dataSource = user!.myCards
        }
        self.currentIndex = self.dataSource.indexOf(card)!
    }
    //MARK: Page Control Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! MainContentVC).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        var index = (viewController as! MainContentVC).pageIndex
        if index == NSNotFound {
            return nil
        }
        index += 1
        if (index == self.dataSource.count) {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> MainContentVC? {
        if self.dataSource.count == 0 || index >= self.dataSource.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainContentVC") as! MainContentVC
        pageContentViewController.pageIndex = index
        currentIndex = index
        let card  = self.dataSource[index]
        pageContentViewController.loadDataSource(card)
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.dataSource.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    //MARK: Button actions
    @IBAction func myCardsButtonTapped(sender : UIButton){
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    @IBAction func logoutButtonTapped(sender : UIButton) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        self.dismissViewControllerAnimated(false) {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let loginVc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
            appDelegate.window?.rootViewController = loginVc
        }
    }
    @IBAction func scanButtonTapped(sender : UIButton) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            self.mainCardsHandler!()
        }
    }

}

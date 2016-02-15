//
//  MainVC.swift
//  Goyava
//
//  Created by Susim Samanta on 15/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class MainVC: UIViewController,UIPageViewControllerDataSource {

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
    func createMainPages(){
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: MainContentVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainContentVC") as! MainContentVC
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height-64);
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    //MARK: Page Control Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! MainContentVC).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index--
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        var index = (viewController as! MainContentVC).pageIndex
        if index == NSNotFound {
            return nil
        }
        index++
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
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.dataSource.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

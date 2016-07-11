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
    
    @IBOutlet weak var cardIconImageView : UIImageView!
    var mainCardsHandler : MainCardsCompletionHandler?
    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    var dataSource = List<Card>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayPage(self.currentIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func onDismiss(_ handler : MainCardsCompletionHandler) {
        self.mainCardsHandler = handler
    }
    func displayPage(_ atIndex : Int){
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        guard self.dataSource.count > 0 else {
            return
        }
        let startingViewController: MainContentVC = self.storyboard?.instantiateViewController(withIdentifier: "MainContentVC") as! MainContentVC
        startingViewController.loadDataSource(self.dataSource[atIndex])
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRect(x: 0, y: 71, width: view.frame.size.width, height: view.frame.size.height-109);
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
        
        self.setTopImage(atIndex)
    }
    func setTopImage(_ atIndex : Int) {
        let card = self.dataSource[atIndex]
        self.cardIconImageView.image = nil
        ImageLoader.sharedLoader.imageForUrl((card.shop?.logo)!) { (image, url) in
            DispatchQueue.main.async(execute: {
                self.cardIconImageView.image = image
                UtilityManager.drawCircularImage(self.cardIconImageView)
            });
        }
    }
    
    func loadDataSource(_ card : Card) {
        // process data with UI logic
        let realm = try! Realm()
        let user = realm.objects(Client).first
        if user != nil {
            self.dataSource = user!.myCards
        }
        self.currentIndex = self.dataSource.indexOf(card)!
    }
    //MARK: Page Control Data Source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! MainContentVC).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
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
    
    func viewControllerAtIndex(_ index: Int) -> MainContentVC? {
        if self.dataSource.count == 0 || index >= self.dataSource.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainContentVC") as! MainContentVC
        pageContentViewController.pageIndex = index
        currentIndex = index
        let card  = self.dataSource[index]
        pageContentViewController.loadDataSource(card)
        return pageContentViewController
    }
    
    
    
    //MARK: Button actions
    @IBAction func myCardsButtonTapped(_ sender : UIButton){
        self.dismiss(animated: true) { () -> Void in
        }
    }
    @IBAction func logoutButtonTapped(_ sender : UIButton) {
        AuthenticationController.logout { (isFinishedLogout) in
            if isFinishedLogout {
                let realm = try! Realm()
                try! realm.write {
                    realm.deleteAll()
                }
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared().delegate as! AppDelegate
                    appDelegate.loadAuthScene()
                }
            }
        }
        
    }
    @IBAction func scanButtonTapped(_ sender : UIButton) {
        self.dismiss(animated: false) { () -> Void in
            self.mainCardsHandler!()
        }
    }

}

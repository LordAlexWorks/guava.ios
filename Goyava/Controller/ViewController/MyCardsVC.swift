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
    }
    override func viewWillAppear(_ animated: Bool) {
        self.refreshMycards()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setUpUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor.black()
    }
    
    //MARK: Button Actions 
    @IBAction func scanButtonTapped(_ sender : UIButton) {
        goToScannerView()
    }
    
    @IBAction func logoutButtonTapped(_ sender : UIButton) {
        AuthenticationController.logout { (isFinishedLogout) in
            if isFinishedLogout {
                let realm = try! Realm()
                try! realm.write {
                    realm.deleteAllObjects()
                }
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared().delegate as! AppDelegate
                    appDelegate.loadAuthScene()
                }
            }
        }
    }
    
    @IBAction func gridButtonTapped(_ sender : UIButton) {
        let mainVc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        mainVc.modalTransitionStyle = .flipHorizontal
        if self.dataSource.count > 0 {
            let internalCards = self.dataSource[0]
            mainVc.loadDataSource(internalCards[0])
        }
        
        self.present(mainVc, animated: true) { () -> Void in
        }
        mainVc.onDismiss { [weak self]() -> Void in
            self?.goToScannerView()
        }
    }
  
    func createMainPages(){
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: MyCardContentVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCardContentVC") as! MyCardContentVC
        startingViewController.loadDataSource(self.dataSource[0])
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height-100);
        pageViewController?.view.backgroundColor = UIColor.clear()
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
    }
    func refreshMycards() {
        CardsController.getAllCards { (obj, error) in
            if error != nil {
                print(error)
            }else {
                let client = AuthenticationController.getLocalClient()
                client?.myCards = obj as! List<Card>
                DispatchQueue.main.async {
                    self.loadDataSource(client!)
                }
            }
        }
    }
    func loadDataSource(_ client: Client?) {
        // process data with UI logic
        if client != nil {
            let mycards = client!.myCards
            guard mycards.count > 0 else {
                return
            }
            let itemPerPage = 6
            var pageCount = 0
            if mycards.count%itemPerPage == 0 {
                pageCount = mycards.count/6
            }else {
                pageCount = (mycards.count/6)+1
            }
            for index in 0...pageCount-1{
                let startIndex = index*itemPerPage
                var endIndex = (index+1)*itemPerPage-1
                if endIndex > mycards.count {
                    endIndex = mycards.count-1
                }
                let pageItems = List<Card>(mycards[startIndex...endIndex]) 
                self.dataSource.append(pageItems)
            }
            self.createMainPages()
        }
    }
    
    //MARK: Page Control Data Source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! MyCardContentVC).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
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
    
    func viewControllerAtIndex(_ index: Int) -> MyCardContentVC? {
        if self.dataSource.count == 0 || index >= self.dataSource.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyCardContentVC") as! MyCardContentVC
        pageContentViewController.pageIndex = index
        currentIndex = index
        pageContentViewController.loadDataSource(self.dataSource[index])
        return pageContentViewController
    }
    
    //MARK: Scanner
    func goToScannerView(){
        let qrscannerVc = self.storyboard?.instantiateViewController(withIdentifier: "QRScannerVC") as! QRScannerVC
        qrscannerVc.isAuthorizedForCamera { (isGranted) -> Void in
            if isGranted {
                self.present(qrscannerVc, animated: true) { () -> Void in
                }
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Guava need your camera access. Settings->Guava->Camera.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.cancel, handler:{ action in
                    UIApplication.shared().openURL(Foundation.URL(string: UIApplicationOpenSettingsURLString)!)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

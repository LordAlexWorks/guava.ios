//
//  MyCardsVC.swift
//  Guava
//
//  Created by Susim Samanta on 10/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class MyCardsVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMyCardsLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setUpUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
    }
    func setUpMyCardsLayout() {
        let layout = UICollectionViewFlowLayout()
        let gridNib = UINib(nibName: "MyCard", bundle: nil) as UINib
        self.collectionView.registerNib(gridNib, forCellWithReuseIdentifier: "MyCard")
        layout.scrollDirection = .Vertical
        let column = 2
        let itemWidth = floor((view.bounds.size.width - CGFloat(column - 1)) / CGFloat(column))
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.itemSize = CGSizeMake(itemWidth,itemWidth)
        self.collectionView.setCollectionViewLayout(layout, animated: false) { (isAnimated) -> Void in
            self.collectionView.reloadData()
        }
    }
    // MARK: Collection View Data Source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView!,numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(collectionView: UICollectionView!,cellForItemAtIndexPath indexPath: NSIndexPath!) ->UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCard",forIndexPath: indexPath)
        return cell
    }
    //MARK: Button Actions 
    @IBAction func scanButtonTapped(sender : UIButton) {
        let qrscannerVc = self.storyboard?.instantiateViewControllerWithIdentifier("QRScannerVC") as! QRScannerVC
        self.presentViewController(qrscannerVc, animated: true) { () -> Void in
        }
    }
    @IBAction func logoutButtonTapped(sender : UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let loginVc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        appDelegate.window?.rootViewController = loginVc
    }
    @IBAction func gridButtonTapped(sender : UIButton) {
        
    }
}

//
//  MyCardContentVC.swift
//  Goyava
//
//  Created by Susim Samanta on 16/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift

class MyCardContentVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var pageIndex : Int = 0
    var dataSource = List<Card>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Data Source
    func loadDataSource(_ dataSource : List<Card>){
        self.dataSource = dataSource
        self.createGrids()
    }
    // Create 6 Grids
    func createGrids(){
        let totalWidth = Double (view.frame.size.width)
        let totalHeight = Double(view.frame.size.height-100.0)
        let totalRows = 3
        let totalCols = 2
        let width =  totalWidth/Double(totalCols)
        let height = totalHeight/Double(totalRows)
        var index = 0
        for row in 0...totalRows-1 {
            for col in 0...totalCols-1 {
                if index >= self.dataSource.count {
                    return
                }
                let card = self.dataSource[index]
                let myCardView = MyCard.instanceFromNib() as! MyCard
                myCardView.frame = CGRect(x: Double(col)*width, y: Double(row)*height, width: width, height: height)
                myCardView.tag = index
                self.addTapGestureOnView(myCardView)
                myCardView.loadWithDataSource(card)
                self.view.addSubview(myCardView)
                index += 1
            }
        }
    }
    
    func addTapGestureOnView(_ view : UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.isUserInteractionEnabled =  true
        view.addGestureRecognizer(tap)
    }
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let mainVc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        mainVc.modalTransitionStyle = .flipHorizontal
        let myCardView = sender?.view as! MyCard
        mainVc.loadDataSource(myCardView.card!)
        self.present(mainVc, animated: true) { () -> Void in
        }
        mainVc.onDismiss { [weak self]() -> Void in
            self?.goToScannerView()
        }
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

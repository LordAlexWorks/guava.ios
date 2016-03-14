//
//  MyCardContentVC.swift
//  Goyava
//
//  Created by Susim Samanta on 16/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class MyCardContentVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var pageIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createGrids()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Create 6 Grids
    func createGrids(){
        let totalWidth = Double (view.frame.size.width)
        let totalHeight = Double(view.frame.size.height-100.0)
        let totalRows = 3
        let totalCols = 2
        let width =  totalWidth/Double(totalCols)
        let height = totalHeight/Double(totalRows)
        
        for row in 0...totalRows-1 {
            for col in 0...totalCols-1 {
                let myCardView = MyCard.instanceFromNib() as! MyCard
                myCardView.frame = CGRect(x: Double(col)*width, y: Double(row)*height, width: width, height: height)
                self.addTapGestureOnView(myCardView)
                self.view.addSubview(myCardView)
            }
        }
    }
    
    func addTapGestureOnView(view : UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        view.userInteractionEnabled =  true
        view.addGestureRecognizer(tap)
    }
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
}

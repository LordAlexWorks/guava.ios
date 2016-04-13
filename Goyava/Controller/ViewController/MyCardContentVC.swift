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
    func loadDataSource(dataSource : List<Card>){
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
                index += 1
                let myCardView = MyCard.instanceFromNib() as! MyCard
                myCardView.frame = CGRect(x: Double(col)*width, y: Double(row)*height, width: width, height: height)
                self.addTapGestureOnView(myCardView)
                myCardView.loadWithDataSource(card)
                self.view.addSubview(myCardView)
            }
        }
    }
    
    func addTapGestureOnView(view : UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.userInteractionEnabled =  true
        view.addGestureRecognizer(tap)
    }
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
}

//
//  MyCardsVC.swift
//  Guava
//
//  Created by Marko Budal on 05/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class MyCardsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, LeftRightButtonDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var leftRightDelegate: LeftRightButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leftRightDelegate = self
        // Do any additional setup after loading the view.
    }
    
    func setNibCell() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.addNib(CustomCell.LeftRightButtonCenterLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
    
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.LeftRightButtonCenterLabel.rawValue, forIndexPath: indexPath) as! LeftRightButtonCenterLabelTableViewCell
            cell.setup("MY CARDS", delegate: leftRightDelegate!)
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    //MARK: LeftRightButtonDelegate
    func leftTopButton(sender: UIButton) {
        print("leftTopButton")
    }
    
    func rightTopButton(sender: UIButton) {
        print("rightTopButton")
    }

}

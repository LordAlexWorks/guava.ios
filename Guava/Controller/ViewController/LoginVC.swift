//
//  LoginVC.swift
//  Guava
//
//  Created by Susim Samanta on 02/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITableViewDataSource, UITableViewDelegate, SignInTableViewDelegate {

     var signDelegate: SignInTableViewDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.view.backgroundColor = UIColor.blackColor()
        signDelegate = self
        
        setNibCell()
    }
    
    func setNibCell() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.addNib(CustomCell.SignIn)
        tableView.addNib(CustomCell.CenterLabel)
        tableView.addNib(CustomCell.LeftLabel)
        tableView.addNib(CustomCell.TextField)
        tableView.addNib(CustomCell.ButtonCenter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.SignIn.rawValue, forIndexPath: indexPath) as! SignInTableViewCell
            cell.setup("SIGNUP", textFontWeight: FontWeight.AHeavy, textSize: 12, delegate: signDelegate!)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("LabelCenterTableViewCell", forIndexPath: indexPath) as! LabelCenterTableViewCell
            cell.setup("Goyava", textFontWeight: FontWeight.AHeavy, textSize: 34)
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("LabelLeftTableViewCell", forIndexPath: indexPath) as! LabelLeftTableViewCell
            cell.setup("WELCOME BACK", textFontWeight: FontWeight.AHeavy, textSize: 12)
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldTableViewCell", forIndexPath: indexPath) as! TextFieldTableViewCell
            cell.setup("EMAIL", textFontWeight: FontWeight.ABlack, textSize: 22)
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldTableViewCell", forIndexPath: indexPath) as! TextFieldTableViewCell
            cell.setup("PASSWORD", textFontWeight: FontWeight.ABlack, textSize: 22)
            
            return cell
        case 5:
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCenterTableViewCell", forIndexPath: indexPath) as! ButtonCenterTableViewCell
            cell.setup("LOGIN", buttonType: ButtonType.LOG, textFontWeight: FontWeight.AHeavy, textSize: 13)
            
            return cell
        case 6:
            let cell = tableView.dequeueReusableCellWithIdentifier("LabelCenterTableViewCell", forIndexPath: indexPath) as! LabelCenterTableViewCell
            cell.setup("OR", textFontWeight: FontWeight.ABlack, textSize: 8)
            
            return cell
        case 7:
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCenterTableViewCell", forIndexPath: indexPath) as! ButtonCenterTableViewCell
            cell.setup("LOGIN WITH FACEBOOK", buttonType: ButtonType.FB, textFontWeight: FontWeight.AHeavy, textSize: 13)
            
            return cell
        case 8:
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCenterTableViewCell", forIndexPath: indexPath) as! ButtonCenterTableViewCell
            cell.setup("LOGIN WITH TWITTER", buttonType: ButtonType.TWITTER, textFontWeight: FontWeight.AHeavy, textSize: 13)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 3, 4, 6:
            return 50
        case 1:
            return 150
        case 2:
            return 30
        case 5,7,8:
            return 75
        default:
            return 0
        }
    }
    
    //MARK: SignInTableViewDelegate
    func signInButtonTapped(sender: UIButton) {
        performSegueWithIdentifier("signInToSingUpSegue", sender: nil)
    }
    

}

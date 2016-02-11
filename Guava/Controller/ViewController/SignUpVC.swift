//
//  SignUpVC.swift
//  Guava
//
//  Created by Marko Budal on 05/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITableViewDataSource, UITableViewDelegate, SignInTableViewDelegate,ButtonCenterTableViewDelegate {

    var signDelegate: SignInTableViewDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signDelegate = self
        
        setNibCell()
        addBackgroundTapGesture()
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

    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.SignIn.rawValue, forIndexPath: indexPath) as! SignInTableViewCell
            cell.setup("LOGIN", textFontWeight: FontWeight.AHeavy, textSize: 12, delegate: signDelegate!)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.CenterLabel.rawValue, forIndexPath: indexPath) as! LabelCenterTableViewCell
            cell.setup("Goyava", sizeLabel: 30)
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.LeftLabel.rawValue, forIndexPath: indexPath) as! LabelLeftTableViewCell
            cell.setup("WE JUST NEED A FEW DETAILS")
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.TextField.rawValue, forIndexPath: indexPath) as! TextFieldTableViewCell
            cell.setup("EMAIL", fieldType: .EmailType)
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.TextField.rawValue, forIndexPath: indexPath) as! TextFieldTableViewCell
            cell.setup("PASSWORD", fieldType: .PassowrdType)
            
            return cell
        case 5:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.ButtonCenter.rawValue, forIndexPath: indexPath) as! ButtonCenterTableViewCell
            cell.setup("CREATE ACCOUNT", buttonType: ButtonType.LOG, textFontWeight: FontWeight.AHeavy, textSize: 13, delegate: self)
            
            return cell
        case 6:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.CenterLabel.rawValue, forIndexPath: indexPath) as! LabelCenterTableViewCell
            cell.setup("OR", textFontWeight: FontWeight.ABlack, textSize: 8)
            
            return cell
        case 7:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.ButtonCenter.rawValue, forIndexPath: indexPath) as! ButtonCenterTableViewCell
            cell.setup("SIGNUP WITH FACEBOOK", buttonType: ButtonType.FB, textFontWeight: FontWeight.AHeavy, textSize: 13, delegate: self)
            
            return cell
        case 8:
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomCell.ButtonCenter.rawValue, forIndexPath: indexPath) as! ButtonCenterTableViewCell
            cell.setup("SIGNUO WITH TWITTER", buttonType: ButtonType.TWITTER, textFontWeight: FontWeight.AHeavy, textSize: 13, delegate: self)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 3, 4, 6:
            return view.bounds.height * 0.075
        case 1:
            return view.bounds.height * 0.24
        case 2:
            return view.bounds.height * 0.048
        case 5,7,8:
            return view.bounds.height * 0.12
        default:
            return 0
        }
    }
    
    //MARK: SignInTableViewDelegate
    func signInButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //MARK: Login navigation
    func loginButtonTapped() {
        goToScannerView()
    }
    func goToScannerView(){
        let qrscannerVc = self.storyboard?.instantiateViewControllerWithIdentifier("QRScannerVC") as! QRScannerVC
        self.presentViewController(qrscannerVc, animated: true) { () -> Void in
            
        }
    }
    //MARK: Background Tap
    func addBackgroundTapGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.tableView.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

//
//  AppDelegate.swift
//  Guava
//
//  Created by Susim Samanta on 02/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import AWSMobileAnalytics
import Reachability
import SafariServices
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,SFSafariViewControllerDelegate {

    var window: UIWindow?
    var user : User?
    var reach: Reachability?
    var isNetworkReachable = false
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        self.user = AuthenticationController.getLocalUser()
        if user != nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let myCardVC = mainStoryboard.instantiateViewControllerWithIdentifier("MyCardsVC") as! MyCardsVC
            self.window?.rootViewController = myCardVC
        }else {
            self.loadAuthScene()
        }
        setUpGeneralSettings()
        loadLookabackSettings()
        setupAnalytics()
        Fabric.with([Crashlytics.self]);
        self.addReachability()
        return true
    }
    func loadAuthScene() {
        let urlString = "http://proactives.site/oauth/authorize?client_id=8f05f8c75f0b1c45c6ef08a6b51519d82d41c1eac0d0f7d169afce403322446e&redirect_uri=guavaios://guavaios/callback&response_type=code"
        let svc = SFSafariViewController(URL: NSURL(string: urlString)!)
        svc.delegate = self
       self.window?.rootViewController = svc
    }
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        print("Safari:\(url)")
        return true
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    //MARK: Common Set up
    func setUpGeneralSettings(){
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    func loadLookabackSettings(){
        /*Lookback.setupWithAppToken("HASk58eZD3Gfovze6")
        Lookback.sharedLookback().shakeToRecord = true
        Lookback.sharedLookback().feedbackBubbleVisible = true*/
    }
    func setupAnalytics(){
        let analytics = AWSMobileAnalytics(forAppId: "50d4101badbd4161801e978d1dfa1313", identityPoolId: "us-east-1:649c5a0c-5dc4-489f-93d9-2515e12695e8")
        print(analytics.description)
    }
    // add Reachability method
    func addReachability(){
        self.reach = Reachability.reachabilityForInternetConnection()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: kReachabilityChangedNotification,object: nil)
        if self.reach!.isReachableViaWiFi() || self.reach!.isReachableViaWWAN() {
            self.isNetworkReachable = true
        } else {
            self.isNetworkReachable = false
        }
        self.reach!.startNotifier()
    }
    func reachabilityChanged(notification: NSNotification) {
        if self.reach!.isReachableViaWiFi() || self.reach!.isReachableViaWWAN() {
            self.isNetworkReachable = true
        } else {
           self.isNetworkReachable = false
        }
    }
}


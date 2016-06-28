//
//  AppConstants.swift
//  Goyava
//
//  Created by Susim Samanta on 07/03/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

enum URL : String {
    case baseURL = "http://api.goyava.site"
    case apiEndPoint = "/v1/clients/"
    case cardsEndPoint = "/cards.json"
    case activityEndPoint = "activities.json"
    case proactiveBaseURL = "http://proactives.site"
    case proactiveAuthEndPoint = "/oauth/authorize?"
    case proactiveTokenEndPoint = "/oauth/token"
}
enum ApplicationSecrets : String {
    case ApplicationId = "8f05f8c75f0b1c45c6ef08a6b51519d82d41c1eac0d0f7d169afce403322446e"
    case ApplicationSecret = "a0760888ff6aed65661eb016024674da1374ad8599ce11e3a4c128bf3d8be674"
    case callBackURL = "guavaios://guavaios/callback"
}

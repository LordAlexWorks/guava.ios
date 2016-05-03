//
//  UIViewControllerExtension.swift
//  Goyava
//
//  Created by Susim Samanta on 03/05/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

extension UIViewController {
    func addBackgroundTapGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTapGesture(gestureRecognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
}
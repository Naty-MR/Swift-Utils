//
//  UIViewController+HideKeyboard.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 12/09/2018.
//  Copyright © 2018. All rights reserved.
//
import UIKit
import Foundation


extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


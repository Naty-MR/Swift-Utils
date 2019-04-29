//
//  UIViewController+CustomLoadingView.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

private var AssociatedObjectHandle: UInt8 = 0
extension UIViewController {
         var customLoadingView: CustomLoadingView? {
            get {
                if let customLV = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? CustomLoadingView {
                    return customLV
                } else {
                    self.customLoadingView =  CustomLoadingView(container: self.view)
                    return self.customLoadingView
                }
            }
            set {
                objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
    }
    
    func showLoadingView(withMessage message: String = "") {
        self.customLoadingView?.show(withMessage: message)
    }
    
    func hideLoadingView() {
        self.customLoadingView?.hide()
    }
    
    func loadingViewIsVisible() -> Bool {
        return (self.customLoadingView?.isVisibleInView())!
    }
}

//
//  UIViewController+Alert.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 12/12/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertMessage(title: String, message: String = "", okActionTitle: String = "Aceptar", okAction: ((UIAlertAction) -> Void)? = nil, showCancelAction: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okActionTitle, style: .default, handler: okAction))
        if showCancelAction {
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showGenericErrorMessage() {
        showAlertMessage(title: "Ha ocurrido un error", showCancelAction: false)
    }
    
    func showRetryErrorMessage(okAction: ((UIAlertAction) -> Void)?) {
        showAlertMessage(title: "Ha ocurrido un error", okActionTitle: "Reintentar", okAction: okAction, showCancelAction: false)
    }
}

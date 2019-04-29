//
//  UIImageView+ImageFromURL.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 03/02/2019.
//  Copyright © 2019. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromUrl(_ url: URL) {
        self.image = nil
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}

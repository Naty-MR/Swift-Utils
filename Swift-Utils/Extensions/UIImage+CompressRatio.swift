//
//  UIImage+CompressRatio.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 22/5/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func compressWithMaxSize(_ maxSize: CGFloat) -> UIImage {
        var imgData = self.jpegData(compressionQuality: 1)
        var compressingValue: CGFloat = 1
        
        while (CGFloat((imgData?.count)!) > maxSize) {
            compressingValue -= 0.1
            imgData = self.jpegData(compressionQuality: compressingValue)
        }
        
        return UIImage(data: imgData!)!
    }
}

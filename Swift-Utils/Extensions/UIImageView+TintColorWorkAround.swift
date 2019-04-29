//
//  UIImageView+TintColorWorkAround.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 16/01/2019.
//  Copyright © 2019. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        tintColorDidChange()
    }
}

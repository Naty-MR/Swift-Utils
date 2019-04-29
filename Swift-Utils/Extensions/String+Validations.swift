//
//  String+Validations.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 21/01/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

extension String {
    public func hasSpecialCharacters() -> Bool {
        let characterSet = NSCharacterSet(charactersIn: "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLKMNÑOPQRSTUVWXYZ0123456789. áéíóúÁÉÍÓÚ").inverted
        return (self.rangeOfCharacter(from: characterSet) != nil)
    }
    
    public func hasNoNumbersCharacters() -> Bool {
        let characterSet = NSCharacterSet(charactersIn: "0123456789").inverted
        return (self.rangeOfCharacter(from: characterSet) != nil)
    }
    
    public func replaceSpecialCharacters() -> String {
        let regex = try? NSRegularExpression(pattern: "[^a-zA-Zá-úÁ-Ú\\d\\s.]")
        let mutable = NSMutableString(string: self)
        regex?.replaceMatches(in: mutable, options: .reportProgress, range: NSRange(location: 0,length: self.count), withTemplate: " ")
        return mutable as String
    }
}

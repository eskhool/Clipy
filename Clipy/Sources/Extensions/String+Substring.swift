//
//  String+Substring.swift
//
//  Clipy
//  GitHub: https://github.com/clipy
//  HP: https://clipy-app.com
//
//  Created by Econa77 on 2016/03/17.
//
//  Copyright © 2015-2018 Clipy Project.
//

import Foundation

extension String {
    subscript (range: CountableClosedRange<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound, limitedBy: self.endIndex) ?? self.startIndex
        let endIndex = self.index(self.startIndex, offsetBy: range.upperBound, limitedBy: self.endIndex) ?? self.endIndex

        return String(self[startIndex..<endIndex])
    }

    func continueHash(hash: Int = 0) -> Int {
        var result = UInt64(truncatingIfNeeded: hash)
        let buf = [UInt8](self.utf8)
        for bit in buf {
            result = result &* 31 &+ UInt64(bit)
        }
        return Int(truncatingIfNeeded: result)
    }
}

extension Data {
    func continueHash(hash: Int) -> Int {
        return base64EncodedString().continueHash(hash: hash)
    }
}

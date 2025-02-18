//
//  NSCoding+Archive.swift
//
//  Clipy
//  GitHub: https://github.com/clipy
//  HP: https://clipy-app.com
//
//  Created by Econa77 on 2016/11/19.
//
//  Copyright © 2015-2018 Clipy Project.
//

import Foundation

extension NSCoding {
    func archive() -> Data {
        if #available(OSX 10.13, *) {
            if let data = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true) {
                return data
            }
        }
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}

extension Array where Element: NSCoding {
    func archive() -> Data {
        if #available(OSX 10.13, *) {
            if let data = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true) {
                return data
            }
        }
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}

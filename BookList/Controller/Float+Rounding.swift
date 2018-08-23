//
//  Float+Rounding.swift
//  BookList
//
//  Created by Wei Lun on 24/08/2018.
//  Copyright © 2018 Wei Lun. All rights reserved.
//

import Foundation

extension Float {
    public func roundToTwoPrecision() -> Float {
        return (self * 100).rounded() / 100
    }
}

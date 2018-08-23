//
//  Picker.swift
//  BookList
//
//  Created by Wei Lun on 24/08/2018.
//  Copyright © 2018 Wei Lun. All rights reserved.
//

import Foundation
class Picker {
    enum Picker: Int {
        case categoryPicker = 0
        case statusPicker = 1
    }
    
    static let statusList = ["Read", "Not Yet Read", "Reading"]
    static let categoryList = ["Fiction", "Adventure", "Romance"]
    
}

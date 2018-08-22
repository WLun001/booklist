//
//  Book.swift
//  BookList
//
//  Created by Wei Lun on 22/08/2018.
//  Copyright © 2018 Wei Lun. All rights reserved.
//

import Foundation

class BookModel {
    var id: UUID
    var title: String
    var author: String
    var category: String
    var publishedDate: Date
    var status: String
    var ratings: Float
    
    init(id: UUID, title: String, author: String, category: String, publishedDate: Date, status: String, ratings: Float) {
        self.id = id
        self.title = title
        self.author = author
        self.category = category
        self.publishedDate = publishedDate
        self.status = status
        self.ratings = ratings
    }
}

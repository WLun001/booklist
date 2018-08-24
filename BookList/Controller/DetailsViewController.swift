//
//  DetailsViewController.swift
//  BookList
//
//  Created by Wei Lun on 22/08/2018.
//  Copyright © 2018 Wei Lun. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var detailsBook: Book!
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        
        if let book = detailsBook {
            titleLabel.text = book.title
            categoryLabel.text = book.category
            authorLabel.text = book.author
            publishedDateLabel.text = dateFormatter.string(from: book.published_date!)
            ratingsLabel.text = String(book.ratings)
            statusLabel.text = book.status
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        // for testing purpose
        print("Returning to First Scene")
        
    }
    
    @IBAction func returnFromEdit(segue: UIStoryboardSegue) {
        titleLabel.text = detailsBook.title
        categoryLabel.text = detailsBook.category
        authorLabel.text = detailsBook.author
        publishedDateLabel.text = dateFormatter.string(from: detailsBook.published_date!)
        ratingsLabel.text = String(detailsBook.ratings.roundToTwoPrecision())
        statusLabel.text = detailsBook.status
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editVS = segue.destination as! EditViewController
        editVS.selectedBook = detailsBook
    }
}

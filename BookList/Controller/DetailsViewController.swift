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
    var selectedBook: BookModel!
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        
        if let book = selectedBook {
            titleLabel.text = book.title
            categoryLabel.text = book.category
            authorLabel.text = book.author
            publishedDateLabel.text = dateFormatter.string(from: book.publishedDate)
            ratingsLabel.text = String(book.ratings)
            statusLabel.text = book.status
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        // for testing purpose
        print("Returning to First Scene")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

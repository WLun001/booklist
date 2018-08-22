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
    
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error in app")
            return
        }
        appDelegate = delegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        do {
            let books = try managedContext.fetch(fetchRequest)
            print(books.count)
            
        } catch {
            print(error.localizedDescription)
        }

        // Do any additional setup after loading the view.
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

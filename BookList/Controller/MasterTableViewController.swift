//
//  MasterTableViewController.swift
//  BookList
//
//  Created by Wei Lun on 22/08/2018.
//  Copyright © 2018 Wei Lun. All rights reserved.
//

import UIKit
import CoreData

class MasterTableViewController: UITableViewController {
    
    enum Segue: String {
        case add = "toAdd"
        case details = "toDetails"
    }
    
    var bookList = [Book]()
    var newBook: Book!
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error in app")
            return
        }
        appDelegate = delegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "BookCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "BookCell")
        }
        cell!.textLabel!.text = bookList[indexPath.row].title
        cell!.detailTextLabel?.text = bookList[indexPath.row].author
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
            fetchRequest.predicate = NSPredicate(format: "id = %@", bookList[indexPath.row].id! as CVarArg)
            bookList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            do {
                let books = try managedContext.fetch(fetchRequest)
                if !books.isEmpty {
                    let foundBook = books[0]
                    managedContext.delete(foundBook)
                    do {
                        try managedContext.save()
                        print("date deleted")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            fetchData()
            tableView.reloadData()
        }
    }
    
    func fetchData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        do {
            bookList = try managedContext.fetch(fetchRequest) as! [Book]
            bookList.sort(by: { ($0.title?.lowercased())! < ($1.title?.lowercased())!})
            print(bookList.count)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func returnFromAdd(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == Segue.details.rawValue {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let detailsVC = segue.destination as! DetailsViewController
                    detailsVC.detailsBook = bookList[indexPath.row]
                }
            } else if identifier == Segue.add.rawValue {
                newBook = nil
            }
        }
    }
}

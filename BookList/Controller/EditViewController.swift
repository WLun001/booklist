//
//  ViewController.swift
//  BookList
//
//  Created by Wei Lun on 29/07/2018.
//  Copyright © 2018 Wei Lun. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingsSlider: UISlider!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var statusPicker: UIPickerView!
    
    var selectedCategoryRow: Int = 0
    var selectedStatusRow: Int = 0
    let dateFormatter = DateFormatter()
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    var selectedBook: Book!
    var foundBook: Book!


    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setDate(Date(), animated:true)
        dateFormatter.dateFormat = "dd MMM, yyyy"
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        statusPicker.dataSource = self
        statusPicker.delegate = self
        
        if let book = selectedBook {
            titleTextField.text = book.title
            categoryPicker.selectRow(Picker.categoryList.index(of: book.category!)!,inComponent:0, animated: true)
            authorTextField.text = book.author
            datePicker.date = book.published_date!
            ratingsSlider.value = book.ratings
            statusPicker.selectRow(Picker.statusList.index(of: book.status!)!, inComponent: 0, animated: true)
        }
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error in app")
            return
        }
        appDelegate = delegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == Picker.Picker.categoryPicker.rawValue {
            return Picker.categoryList.count
        } else {
            return Picker.statusList.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == Picker.Picker.categoryPicker.rawValue {
            return Picker.categoryList[row]
        } else {
            return Picker.statusList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == Picker.Picker.categoryPicker.rawValue {
            selectedCategoryRow = row
        } else {
            selectedStatusRow = row
        }
    }
    @IBAction func datePickerDidSelect(_ sender: Any) {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    @IBAction func ratingsSliderDidSelect(_ sender: Any) {
        ratingsLabel.text = String(ratingsSlider.value.roundToTwoPrecision())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateDb()
        selectedBook = foundBook
//        selectedBook.title = titleTextField.text
//        selectedBook.category = Picker.categoryList[selectedCategoryRow]
//        selectedBook.author = authorTextField.text
//        selectedBook.published_date = datePicker.date
//        selectedBook.ratings = ratingsSlider.value
//        selectedBook.status = Picker.statusList[selectedStatusRow]
    
    }
    func updateDb() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        fetchRequest.predicate = NSPredicate(format: "id = %@", selectedBook.id! as CVarArg)
        do {
            let books = try managedContext.fetch(fetchRequest)
            if !books.isEmpty {
                foundBook = books[0] as! Book
                foundBook.setValue(titleTextField.text, forKey: "title")
                foundBook.setValue(Picker.categoryList[selectedCategoryRow], forKey: "category")
                foundBook.setValue(authorTextField.text, forKey: "author")
                foundBook.setValue(datePicker.date, forKey: "published_date")
                foundBook.setValue(ratingsSlider.value, forKey: "ratings")
                foundBook.setValue(Picker.statusList[selectedStatusRow], forKey: "status")
                
                do {
                    try managedContext.save()
                    print("date updated")
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Saved Status", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
}


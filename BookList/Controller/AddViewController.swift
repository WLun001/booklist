//
//  AddViewController.swift
//  BookList
//
//  Created by Wei Lun on 07/08/2018.
//  Copyright © 2018 Wei Lun. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var statusPicker: UIPickerView!
    
    var selectedCategoryRow: Int = 0
    var selectedStatusRow: Int = 0
    
    let dateFormatter = DateFormatter()
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setDate(Date(), animated:true)
        dateFormatter.dateFormat = "dd MMM, yyyy"
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        statusPicker.dataSource = self
        statusPicker.delegate = self
        
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

    @IBAction func datePickerDidSelect(_ sender: UIDatePicker) {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    @IBAction func ratingsSliderDidSelect(_ sender: Any) {
        ratingLabel.text = String(ratingSlider.value.roundToTwoPrecision())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveToDb()
    }
    
    func saveToDb() {
        let entity = NSEntityDescription.entity(forEntityName: "Book", in: managedContext)!
        let book = NSManagedObject(entity: entity, insertInto: managedContext)
        book.setValue(UUID.init(), forKey: "id")
        book.setValue(titleTextField.text, forKey: "title")
        book.setValue(Picker.categoryList[selectedCategoryRow], forKey: "category")
        book.setValue(authorTextField.text, forKey: "author")
        book.setValue(datePicker.date, forKey: "published_date")
        book.setValue(ratingSlider.value, forKey: "ratings")
        book.setValue(Picker.statusList[selectedStatusRow], forKey: "status")
        
        do {
            try managedContext.save()
            print("saves successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Saved Status", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil ))
        self.present(alertController, animated: true, completion: nil)
    }
}

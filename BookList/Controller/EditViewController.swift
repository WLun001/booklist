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
    @IBAction func datePickerDidSelect(_ sender: Any) {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    @IBAction func ratingsSliderDidSelect(_ sender: Any) {
        ratingsLabel.text = String(ratingsSlider.value.roundToTwoPrecision())
    }
    
}


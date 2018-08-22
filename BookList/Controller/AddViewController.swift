//
//  AddViewController.swift
//  BookList
//
//  Created by Wei Lun on 07/08/2018.
//  Copyright © 2018 Wei Lun. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var statusPicker: UIPickerView!
    
    enum Picker: Int {
        case categoryPicker = 0
        case statusPicker = 1
    }
    
    let statusList = ["Read", "Not Yet Read", "Reading"]
    let category = ["Fiction", "Adventure", "Romance"]
    
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setDate(Date(), animated:true)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        statusPicker.dataSource = self
        statusPicker.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == Picker.categoryPicker.rawValue {
            return category.count
        } else {
            return statusList.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == Picker.categoryPicker.rawValue {
            return category[row]
        } else {
            return statusList[row]
        }
    }

    @IBAction func datePickerSelectionChange(_ sender: UIDatePicker) {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    func saveToDb() {
        
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

//
//  ViewController.swift
//  BookList
//
//  Created by Wei Lun on 29/07/2018.
//  Copyright © 2018 Wei Lun. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var ratingsSlider: UISlider!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var statusPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


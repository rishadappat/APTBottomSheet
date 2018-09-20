//
//  ViewController.swift
//  APTBottomSheet
//
//  Created by Rishad Appat on 9/8/18.
//  Copyright © 2018 Rishad Appat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, stringPickerDelegate, dateTimePickerDelegate {
    
    @IBOutlet weak var timePicker: UITextField!
    @IBOutlet weak var dateTimePicker: UITextField!
    @IBOutlet weak var datePicker: UITextField!
    @IBOutlet weak var etSelectValue: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        etSelectValue.delegate = self
        datePicker.delegate = self
        dateTimePicker.delegate = self
        timePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openBottomSheet(_ sender: Any) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
        view.backgroundColor = .brown
        let bottomSheetBuilder = BottomSheetBuilder().build(with: view)
        bottomSheetBuilder.show(from: self)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == etSelectValue)
        {
            let stringPicker = BottomSheetBuilder().buildStringPicker(with: ["dog", "cat", "parrot", "boat", "cricket", "java", "swift"], and: "Select items")
            stringPicker.theme = .dark
            stringPicker.stringpickerdelegate = self
            stringPicker.show(from: self)
        }
        else if(textField == datePicker)
        {
            let datePicker = BottomSheetBuilder().buildDatePicker(withTitle: "Select Date")
            datePicker.theme = .light
            datePicker.datetimepickerdelegate = self
            datePicker.show(from: self)
        }
        else if(textField == dateTimePicker)
        {
            let dateTimePicker = BottomSheetBuilder().buildDateTimePicker(withTitle: "Select Date Time")
            dateTimePicker.theme = .dark
            dateTimePicker.datetimepickerdelegate = self
            dateTimePicker.show(from: self)
        }
        else
        {
            let timePicker = BottomSheetBuilder().buildTimePicker(withTitle: "Select Time")
            timePicker.theme = .light
            timePicker.datetimepickerdelegate = self
            timePicker.show(from: self)
        }
        return false
    }
    
    func stringPickerSelected(selected value: String, at row: Int) {
        print(value)
    }
    
    func dateTimePickerSelected(selected date: Date) {
        print(date)
    }
    
}


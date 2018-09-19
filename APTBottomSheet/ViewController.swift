//
//  ViewController.swift
//  APTBottomSheet
//
//  Created by Rishad Appat on 9/8/18.
//  Copyright © 2018 Rishad Appat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var etSelectValue: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        etSelectValue.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openBottomSheet(_ sender: Any) {
//        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
//        view.backgroundColor = .brown
//        let bottomSheetBuilder = BottomSheetBuilder().build(with: view)
//        bottomSheetBuilder.show(from: self)
//
//        let stringPicker = BottomSheetBuilder().buildStringPicker(with: ["dog", "cat", "parrot", "boat", "cricket", "java", "swift"], and: "Select items")
//        stringPicker.theme = .dark
//        stringPicker.show(from: self)
//
//        let datePicker = BottomSheetBuilder().buildDatePicker(withTitle: "Select Date")
//        datePicker.theme = .light
//        datePicker.show(from: self)
        
        let datePicker = BottomSheetBuilder().buildTimePicker(withTitle: "Select Time")
        datePicker.theme = .light
        datePicker.show(from: self)
        
//        let dateTimePicker = BottomSheetBuilder().buildDateTimePicker()
//        dateTimePicker.theme = .dark
//        dateTimePicker.show(from: self)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let stringPicker = BottomSheetBuilder().buildStringPicker(with: ["dog", "cat", "parrot", "boat", "cricket", "java", "swift"], and: "Select items")
        stringPicker.theme = .dark
        stringPicker.show(from: self)
        return false
    }
}


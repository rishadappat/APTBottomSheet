//
//  BottomSheet.swift
//  APTBottomSheet
//
//  Created by Rishad Appat on 9/8/18.
//  Copyright © 2018 Rishad Appat. All rights reserved.
//

import UIKit

class BottomSheet: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    enum BottomSheetType {
        case bottomSheet
        case datePicker
        case timePicker
        case dateTimePicker
        case stringPicker
    }
    
    enum Theme {
        case light
        case dark
    }
    
    var bottomSheetview: UIView?
    var bgView: UIView!
    var type: BottomSheetType!
    var theme: Theme!
    var stringPickerData: [String]!
    var picker: UIPickerView!
    var datePicker: UIDatePicker!
    var selectedDate: Date!
    var completionHandler: ((_ success:Dictionary<String, Any>) -> Void)?
    var pickerTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(theme == nil)
        {
            theme = .light
        }
        self.view.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(BottomSheet.handleTap(_:)))
        bgView.addGestureRecognizer(tap)
        self.view.addSubview(bgView)
        if(type == BottomSheetType.bottomSheet)
        {
            setBottomSheet()
        }
        else if(type == BottomSheetType.stringPicker)
        {
            addBlureToView()
            setStringPicker()
        }
        else if(type == BottomSheetType.datePicker || type == BottomSheetType.dateTimePicker || type == BottomSheetType.timePicker)
        {
            addBlureToView()
            setDateOrDateTimePicker()
        }
    }
    
    func setBottomSheet()
    {
        self.view.addSubview(bottomSheetview!)
        addShadow(view: bottomSheetview!)
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheetview?.frame.origin = CGPoint.init(x: 0, y: (self.bottomSheetview?.frame.origin.y)! - (self.bottomSheetview?.frame.size.height)!)
            self.bgView.frame.size.height = self.bgView.frame.size.height - (self.bottomSheetview?.frame.size.height)!
            self.bgView.alpha = 1.0
        }) { (completed) in
            print("BottomSheet Shown")
        }
    }
    
    func setStringPicker()
    {
        addHeadeView()
        
        picker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: (bottomSheetview?.frame.size.width)!, height: (bottomSheetview?.frame.size.height)! - 44))
        self.picker.backgroundColor = .clear
        bottomSheetview?.addSubview(picker)
        self.picker.showsSelectionIndicator = true
        self.picker.delegate = self
        self.picker.dataSource = self
        setBottomSheet()
    }
    
    func setDateOrDateTimePicker()
    {
        addHeadeView()
        datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: 44, width: (bottomSheetview?.frame.size.width)!, height: (bottomSheetview?.frame.size.height)! - 44))
        let textColor = theme == Theme.light ? UIColor.black : UIColor.white
        datePicker.setValue(textColor, forKeyPath: "textColor")
        self.datePicker.backgroundColor = .clear
        bottomSheetview?.addSubview(datePicker)
        if(type == BottomSheetType.datePicker)
        {
             datePicker.datePickerMode = .date
        }
        else if(type == BottomSheetType.dateTimePicker)
        {
             datePicker.datePickerMode = .dateAndTime
        }
        else
        {
            datePicker.datePickerMode = .time
        }
        datePicker.addTarget(self, action: #selector(BottomSheet.datePickerValueChanged), for: UIControl.Event.valueChanged)
        setBottomSheet()
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        selectedDate = sender.date
        print(dateFormatter.string(from: sender.date))
    }
    
    func addHeadeView()
    {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        //headerView.backgroundColor = .yellow
        
        let cancelButton = UIButton.init(type: .system)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.frame = CGRect.init(x: 0, y: 0, width: 80, height: headerView.frame.size.height)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(BottomSheet.cancelButtonClicked(_:)), for: .touchUpInside)
        //cancelButton.setTitleColor(UIColor.red, for: .normal)
        
        let doneButton = UIButton.init(type: .system)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        doneButton.frame = CGRect.init(x: headerView.frame.size.width - 80, y: 0, width: 80, height: headerView.frame.size.height)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(BottomSheet.doneButtonClicked(_:)), for: .touchUpInside)
        //doneButton.setTitleColor(UIColor.red, for: .normal)
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 80, y: 0, width: headerView.frame.size.width - 160, height: headerView.frame.size.height))
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = theme == .light ? UIColor.black : UIColor.white
        titleLabel.text = pickerTitle
        
        headerView.addSubview(doneButton)
        headerView.addSubview(cancelButton)
        headerView.addSubview(titleLabel)
        bottomSheetview?.addSubview(headerView)
    }
    
    private func addShadow(view: UIView)
    {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red:0.11, green:0.12, blue:0.17, alpha:1.0).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 8
    }
    
    func addBlureToView()
    {
        let style = theme == Theme.light ? UIBlurEffect.Style.extraLight : UIBlurEffect.Style.dark
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bottomSheetview?.addSubview(blurEffectView)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        dismissBottomSheet()
    }
    
    @objc func cancelButtonClicked(_ sender: UIButton)
    {
        dismissBottomSheet()
    }
    
    @objc func doneButtonClicked(_ sender: UIButton)
    {
        if(type == .stringPicker)
        {
            print(stringPickerData[picker.selectedRow(inComponent: 0)])
        }
        else
        {
            print(selectedDate!)
        }
        dismissBottomSheet()
    }
    
    @objc func dismissBottomSheet()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheetview?.frame.origin = CGPoint.init(x: 0, y: UIScreen.main.bounds.height)
            self.bgView.frame.size.height = self.view.frame.size.height
            self.bgView.alpha = 0.0
        }) { (finished) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print(stringPickerData.count)
        return stringPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print(stringPickerData[row])
        return stringPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let string = stringPickerData[row]
        let textColor = theme == Theme.light ? UIColor.black : UIColor.white
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: textColor])
    }
}

//
//  BottomSheetBuilder.swift
//  APTBottomSheet
//
//  Created by Rishad Appat on 9/8/18.
//  Copyright © 2018 Rishad Appat. All rights reserved.
//

import UIKit

protocol stringPickerDelegate {
    func stringPickerSelected(selected value: String, at row: Int)
}

protocol dateTimePickerDelegate {
    func dateTimePickerSelected(selected date: Date)
}

class BottomSheetBuilder: NSObject {
    
    var stringpickerdelegate: stringPickerDelegate?
    var datetimepickerdelegate: dateTimePickerDelegate?
    var bottomSheet: BottomSheet?
    var stringPickerData: [String]!
    var stringPicker: UIPickerView!
    var theme: BottomSheet.Theme!
    var title: String!
    var stringPickerCompletionHandler: ((_ selected:String, _ index: Int) -> Void)?
    var dateTimePickerCompletionHandler: ((_ selected:Date) -> Void)?
    
    private func build(with view: UIView, bottomSheetType type: BottomSheet.BottomSheetType) -> BottomSheetBuilder
    {
        bottomSheet = BottomSheet()
        bottomSheet?.type = type
        bottomSheet?.stringPickerData = stringPickerData
        let bottomSheetview = view
        bottomSheetview.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.height, width: (bottomSheetview.frame.width), height: (bottomSheetview.frame.height))
        bottomSheet?.bottomSheetview = bottomSheetview
        
        let bgView = UIView()
        bgView.frame = UIScreen.main.bounds
        bgView.backgroundColor = theme == .light ? UIColor.black.withAlphaComponent(0.7) : UIColor.black.withAlphaComponent(0.3)
        bgView.alpha = 0
        bottomSheet?.builder = self
        bottomSheet?.bgView = bgView
        
        bottomSheet?.pickerTitle = title
        
        return self
    }
    
    func build(with view: UIView) -> BottomSheetBuilder
    {
        return build(with: view, bottomSheetType: BottomSheet.BottomSheetType.bottomSheet)
    }
    
    func show(from viewController: UIViewController)
    {
        bottomSheet!.modalPresentationStyle = .overCurrentContext
        bottomSheet?.theme = theme
        viewController.present(bottomSheet!, animated: false, completion: nil)
    }
    
    func dismiss()
    {
        bottomSheet?.dismiss(animated: false, completion: {
            //success()
        })
    }
    
    func buildStringPicker(with array: [String], and title: String) -> BottomSheetBuilder
    {
        stringPickerData = array
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
        view.backgroundColor = .clear
        self.title = title
        return build(with: view, bottomSheetType: BottomSheet.BottomSheetType.stringPicker)
    }
    
    func buildDatePicker(withTitle title: String) -> BottomSheetBuilder
    {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
        view.backgroundColor = .clear
        self.title = title
        return build(with: view, bottomSheetType: BottomSheet.BottomSheetType.datePicker)
    }
    
    func buildDateTimePicker(withTitle title: String) -> BottomSheetBuilder
    {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
        view.backgroundColor = .clear
        self.title = title
        return build(with: view, bottomSheetType: BottomSheet.BottomSheetType.dateTimePicker)
    }
    
    func buildTimePicker(withTitle title: String) -> BottomSheetBuilder
    {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
        view.backgroundColor = .clear
        self.title = title
        return build(with: view, bottomSheetType: BottomSheet.BottomSheetType.timePicker)
    }
}

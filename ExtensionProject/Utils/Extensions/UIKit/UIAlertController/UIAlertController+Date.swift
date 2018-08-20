//
//  UIAlertController+Date.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 8/20/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension UIAlertController {
    /// Add a date picker
    ///
    /// - Parameters:
    ///   - mode: date picker mode
    ///   - date: selected date of date picker
    ///   - minimumDate: minimum date of date picker
    ///   - maximumDate: maximum date of date picker
    ///   - action: an action for datePicker value change
    
    func datePicker(date: Date?, minimumDate: Date? = nil, maximumDate: Date? = nil, action: TimePickerViewController.Action?) {
        let datePicker = TimePickerViewController(mode: .dateAndTime, date: date, minimumDate: minimumDate, maximumDate: maximumDate, local: Locale.init(identifier: "en_GB"), action: action)
        setContentViewController(datePicker, 217)
    }
}

final class TimePickerViewController: UIViewController {
    public typealias Action = (Date) -> Void
    fileprivate var action: Action?
    
    fileprivate lazy var datePicker: UIDatePicker = { [unowned self] in
        $0.addTarget(self, action: #selector(TimePickerViewController.actionForDatePicker), for: .valueChanged)
        return $0
        }(UIDatePicker())
    
    required init(mode: UIDatePickerMode, date: Date? = nil, minimumDate: Date? = nil, maximumDate: Date? = nil, local: Locale? = nil, action: Action?) {
        super.init(nibName: nil, bundle: nil)
        
        datePicker.datePickerMode = mode
        datePicker.date = date ?? Date()
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        datePicker.locale = local
        datePicker.minuteInterval = 15
        self.action = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("has deinitialized")
    }
    
    override func loadView() {
        view = datePicker
    }
    
    @objc func actionForDatePicker() {
        action?(datePicker.date)
    }
    
    public func setDate(_ date: Date) {
        datePicker.setDate(date, animated: true)
    }
}

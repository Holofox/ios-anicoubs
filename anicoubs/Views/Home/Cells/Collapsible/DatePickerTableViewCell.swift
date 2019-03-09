//
//  DatePickerTableViewCell.swift
//  anicoubs
//
//  Created by Holofox on 10.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: BaseTableViewCell, BaseTableViewCellProtocol  {
    
    var delegate: BaseItemDelegateProtocol?
    var model: DatePickerModel!
    
    // MARK: Property
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
            picker.backgroundColor = .white
            picker.minuteInterval = 5
        
        return picker
    }()
    
    func configure(withModel elementModel: BaseItemProtocol) {
        guard let model = elementModel as? DatePickerModel else {
            print("Unable to cast model as DatePickerElement: \(elementModel)")
            return
        }
        
        self.model = model
        datePicker.minimumDate = model.date.addingTimeInterval(TimeInterval(5.0 * 60.0))
        
    }
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(datePicker)
        
        datePicker.fillSuperview()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Delegate
    
   @objc func datePickerValueChanged(_ sender: UIDatePicker){
        self.delegate?.didChangeDate(date: sender.date)
    }

}

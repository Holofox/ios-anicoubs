//
//  DatePickerModel.swift
//  anicoubs
//
//  Created by Holofox on 26.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import Foundation

class DatePickerModel: BaseItemProtocol {
    
    var date: Date
    var type: CellType = .datePicker
    
    init(date: Date) {
        self.date = date
    }
}

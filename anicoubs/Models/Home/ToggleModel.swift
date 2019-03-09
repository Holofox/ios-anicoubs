//
//  ToggleModel.swift
//  anicoubs
//
//  Created by Holofox on 26.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

class ToggleModel: BaseItemProtocol {
    
    var name: String
    var active: Bool
    var type: CellType = .toggle
    
    init(name: String, active: Bool = true) {
        self.name = name
        self.active = active
    }
}

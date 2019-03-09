//
//  SectionModel.swift
//  anicoubs
//
//  Created by Holofox on 26.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

enum CellType: String {
    case header
    case field
    case segment
    case toggle
    case datePicker
}

protocol BaseItemProtocol: class {
    var type: CellType { get }
}

struct SectionModel {
    
    var name: String
    var items: [BaseItemProtocol]
    var collapsed: Bool
    
    init(name: String, items: [BaseItemProtocol], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

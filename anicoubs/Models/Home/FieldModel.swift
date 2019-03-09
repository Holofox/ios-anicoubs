//
//  FieldModel.swift
//  anicoubs
//
//  Created by Holofox on 26.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

class FieldModel: BaseItemProtocol {
    
    var name: String
    var placeholder: String
    var type: CellType { return .field }
    
    init(name: String, placeholder: String) {
        self.name = name
        self.placeholder = placeholder
    }
}

//
//  SegmentedControlModel.swift
//  anicoubs
//
//  Created by Holofox on 26.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

class SegmentedControlModel: BaseItemProtocol {
    
    var items: [String]
    var type: CellType { return .segment }
    
    init(items: [String]) {
        self.items = items
    }
}

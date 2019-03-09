//
//  BaseTableViewCell.swift
//  anicoubs
//
//  Created by Holofox on 02.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

protocol BaseTableViewCellProtocol: class {
    var delegate: BaseItemDelegateProtocol? { get set }
    func configure(withModel: BaseItemProtocol)
}

class BaseTableViewCell : UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

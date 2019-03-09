//
//  BaseCollectionViewCell.swift
//  anicoubs
//
//  Created by Holofox on 02.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

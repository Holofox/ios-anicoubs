//
//  OwnerViewCollectionCell.swift
//  anicoubs
//
//  Created by Holofox on 26.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

class OwnerViewCollectionCell: BaseCollectionViewCell {
    
    let itemsController = OwnerTableViewController()
    
    override func setupViews() {
        let itemsView = itemsController.view!
        
        addSubview(itemsView)
        itemsView.fillSuperview()
    }
    
}

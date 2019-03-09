//
//  PostponedCollectionViewCell.swift
//  anicoubs
//
//  Created by Holofox on 26.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

class PostponedCollectionViewCell: BaseCollectionViewCell {
    
    let itemsController = PostponedTableViewController()
    
    override func setupViews() {
        let itemsView = itemsController.view!
        
        addSubview(itemsView)
        itemsView.fillSuperview()
    }
}

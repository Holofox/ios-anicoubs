//
//  PostponedTableViewController.swift
//  anicoubs
//
//  Created by Holofox on 30.01.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit
import PromiseKit

class PostponedTableViewController: OwnerTableViewController {
   
    override func fetchVideos() {
        
        firstly {
            VKController.wallGet(owner_id: Constants.community, filter: "postponed", offset: "0", count: "25")
            }.done { videos in
                self.videos = videos.items
                self.group = videos.groups
            }.catch { error in
                print(error.localizedDescription)
            }.finally {
                self.tableView.reloadData()
        }
        
    }
    
}

//
//  OwnerTableViewController.swift
//  anicoubs
//
//  Created by Holofox on 30.01.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit
import PromiseKit

class OwnerTableViewController: UITableViewController {
    
    var group: [WallModel.Groups]?
    var videos: [WallModel.Items]?
    
    func fetchVideos() {
        
        firstly {
            VKController.wallGet(owner_id: Constants.community, filter: "owner", offset: "1", count: "25")
            }.done { videos in
                self.videos = videos.items
                self.group = videos.groups
            }.catch { error in
                print(error.localizedDescription)
            }.finally {
                self.tableView.reloadData()
        }
    
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        //tableView.contentInset = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(HomeFeedTableViewCell.self, forCellReuseIdentifier: HomeFeedTableViewCell.reuseIdentifier)
    }
    
    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeFeedTableViewCell.reuseIdentifier, for: indexPath) as! HomeFeedTableViewCell
            cell.selectionStyle = .none
            cell.group = group?[0]
            cell.video = videos?[indexPath.item]
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.width * 0.7
    }
    
}

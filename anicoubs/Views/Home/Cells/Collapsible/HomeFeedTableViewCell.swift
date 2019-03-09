//
//  HomeFeedTableViewCell.swift
//  anicoubs
//
//  Created by Holofox on 02.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class HomeFeedTableViewCell: BaseTableViewCell {
    
    static let reuseIdentifier = "HomeFeedCell"
    
    // MARK: Property
    
    var group: WallModel.Groups?
    var video: WallModel.Items? {
        didSet {
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let title = video?.attachments[0].video?.title, let groupName = group?.name, let numberOfViews = video?.attachments[0].video?.views, let releaseDate = video?.date {
                
                titleLabel.text = title
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(groupName) • \(numberFormatter.string(from: NSNumber(value: numberOfViews))!) views.\n\(releaseDate.toStringWithRelativeTime()) "
                subtitleTextView.text = subtitleText
            }
            
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = group?.photo100 {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.attachments[0].video?.photo640 {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
            imageView.backgroundColor = Color.backgroundColor
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
            imageView.backgroundColor = Color.backgroundColor
            imageView.layer.cornerRadius = 22
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
            view.backgroundColor = Color.separatorColor
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
            // label.numberOfLines = 2
            label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
            textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
            textView.textColor = UIColor.lightGray
            textView.isEditable = false
            textView.isSelectable = false
            textView.isScrollEnabled = false
            textView.font = UIFont.systemFont(ofSize: 12)
        
        return textView
    }()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let view = [thumbnailImageView, userProfileImageView, titleLabel, subtitleTextView, separatorView]
            view.forEach (addSubview(_:))
        
        thumbnailImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: titleLabel.topAnchor, trailing: self.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 8, right: 0))
        
        userProfileImageView.anchor(top: titleLabel.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 4, left: 16, bottom: 0, right: 0), size: .init(width: 44, height: 44))
        
        titleLabel.anchor(top: nil, leading: userProfileImageView.trailingAnchor, bottom: subtitleTextView.topAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 4, right: 0))
        
        subtitleTextView.anchor(top: nil, leading: titleLabel.leadingAnchor, bottom: separatorView.topAnchor, trailing: self.trailingAnchor, size: .init(width: 0, height: 40))
        
        separatorView.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

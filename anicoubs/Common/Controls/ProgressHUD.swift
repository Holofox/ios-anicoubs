//
//  ProgressHUD.swift
//  anicoubs
//
//  Created by Holofox on 27.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class ProgressHUD: UIVisualEffectView {

    var title: String?
    var theme: UIBlurEffect.Style = .light
    
    let strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
    let activityIndicator = UIActivityIndicatorView()

    init(title: String, theme: UIBlurEffect.Style = .light) {
        super.init(effect: UIBlurEffect(style: theme))
        
        self.title = title
        self.theme = theme
        
        [activityIndicator, strLabel].forEach(contentView.addSubview(_:))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            // MARK: Fix view in landscape orientation
            
            frame = CGRect(x: superview.frame.midX - strLabel.frame.width / 2,
                           y: superview.frame.midY - strLabel.frame.height / 2, width: 160, height: 46)
            
            layer.cornerRadius = 15.0
            layer.isHidden = true
            layer.masksToBounds = true
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
            activityIndicator.startAnimating()

            strLabel.text = title
            strLabel.font = .systemFont(ofSize: 14, weight: UIFont.Weight.medium)
            
            switch theme {
            case .dark:
                strLabel.textColor = .white
                activityIndicator.style = .white
            default:
                strLabel.textColor = .gray
                activityIndicator.style = .gray
            }
        }
        
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
    
}

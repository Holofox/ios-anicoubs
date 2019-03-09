//
//  CollapsibleTableViewHeader.swift
//  anicoubs
//
//  Created by Holofox on 10.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate : AnyObject {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    weak var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    // MARK: Property
    
    let nameLabel = UILabel()
    
    let arrowImage: UIImageView = {
        let imageView = UIImageView()
            imageView.image = UIImage(named: "right_arrow")
            imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()

    // MARK: Initialization
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let view = [nameLabel, arrowImage]
        view.forEach (addSubview(_:))
        
        self.backgroundView?.backgroundColor = .gray
        
        // Animate the arrow rotation (see Extensions.swf)
        nameLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0))
        arrowImage.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15), size: .init(width: 20, height: 20))
        arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))

    }

    // MARK: Delegate
    
    @objc private func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }
    
    // MARK: Animate the arrow rotation (see Extensions.swf)
    
    func setCollapsed(_ collapsed: Bool) {
        arrowImage.rotate(collapsed ? 0.0 : .pi / 2)
    }
    
}

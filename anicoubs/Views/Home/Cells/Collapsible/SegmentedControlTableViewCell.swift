//
//  SegmentedControlTableViewCell.swift
//  anicoubs
//
//  Created by Holofox on 15.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class SegmentedControlTableViewCell : BaseTableViewCell, BaseTableViewCellProtocol {
    
    var delegate: BaseItemDelegateProtocol?
    var model: SegmentedControlModel!

    // MARK: Property
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
            control.selectedSegmentIndex = 0
            control.tintColor = .gray
        
        return control
    }()

    // MARK: Initialization
    
    func configure(withModel elementModel: BaseItemProtocol) {
        guard let model = elementModel as? SegmentedControlModel else {
            print("Unable to cast model as SegmentElement: \(elementModel)")
            return
        }
        
        self.model = model
        
        if segmentedControl.numberOfSegments == 0 {
            segmentedControl.replaceSegments(segments: model.items)
            segmentedControl.selectedSegmentIndex = 0
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let view = [segmentedControl]
            view.forEach(addSubview(_:))
        
        segmentedControl.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 10, right: 20))
        segmentedControl.addTarget(self, action: #selector(segmentIndexChanged(_:)), for: .valueChanged)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Delegate
    
    @objc func segmentIndexChanged(_ sender: UISegmentedControl) {
        self.delegate?.didChangeSegment(index: sender.selectedSegmentIndex, title: sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "")
    }
    
}

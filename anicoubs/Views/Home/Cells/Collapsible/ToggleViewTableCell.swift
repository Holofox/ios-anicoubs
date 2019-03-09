//
//  ToggleViewTableCell.swift
//  anicoubs
//
//  Created by Holofox on 11.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class ToggleViewTableCell: BaseTableViewCell, BaseTableViewCellProtocol {
    
    var delegate: BaseItemDelegateProtocol?
    var model: ToggleModel!
    
    // MARK: Property
    
    let nameLabel = UILabel()
    
    let toggle: UISwitch = {
        let toggle = UISwitch()
            toggle.onTintColor = .gray
            toggle.isOn = true
        
        return toggle
    }()
    
    // MARK: Initialization
    
    func configure(withModel elementModel: BaseItemProtocol) {
        guard let model = elementModel as? ToggleModel else {
            print("Unable to cast model as ToggleElement: \(elementModel)")
            return
        }
        
        self.model = model
        switchUpdate(name: model.name)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let view = [nameLabel, toggle]
            view.forEach (addSubview(_:))
        
        nameLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 10, left: 20, bottom: 10, right: 0))
        toggle.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 20))
        toggle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        toggle.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Delegate
    
    @objc func switchChanged(_ sender: UISwitch) {
        delegate?.didChangeStatus(isOn: sender.isOn)
    }
    
    private func switchUpdate(name: String) {
        nameLabel.text = name
    }
    
}

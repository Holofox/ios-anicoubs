//
//  FieldTableViewCell.swift
//  anicoubs
//
//  Created by Holofox on 11.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class FieldTableViewCell: BaseTableViewCell, BaseTableViewCellProtocol {
    
    var model: FieldModel!
    weak var delegate: BaseItemDelegateProtocol?
    
    // MARK: Property
    
    let textField = UITextField()

    // MARK: Initialization
    
    func configure(withModel elementModel: BaseItemProtocol) {
        guard let model = elementModel as? FieldModel else {
            print("Unable to cast model as FieldElement: \(elementModel)")
            return
        }
        
        self.model = model
        
        textField.placeholder = model.placeholder
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let view = [textField]
            view.forEach (addSubview(_:))
        
        textField.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 10, right: 20))
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: Delegate
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        delegate?.didChangeField(text: sender.text ?? "")
    }
    
}

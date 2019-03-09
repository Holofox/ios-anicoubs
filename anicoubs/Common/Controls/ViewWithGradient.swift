//
//  ViewWithGradient.swift
//  anicoubs
//
//  Created by Holofox on 15.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class ViewWithGradient: UIView {
    
    private var gradient = CAGradientLayer()
    
    init(addTo parentView: UIView, colors: [UIColor], locations: [NSNumber]){
        
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 2))
        restorationIdentifier = "__ViewWithGradient"
        
        for subView in parentView.subviews {
            if let subView = subView as? ViewWithGradient {
                if subView.restorationIdentifier == restorationIdentifier {
                    subView.removeFromSuperview()
                    break
                }
            }
        }
        
        let cgColors = colors.map { (color) -> CGColor in
            return color.cgColor
        }
        
        gradient.frame = parentView.frame
        gradient.colors = cgColors
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        backgroundColor = .clear
        
        parentView.addSubview(self)
        parentView.layer.insertSublayer(gradient, at: 0)
        parentView.backgroundColor = .clear
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        clipsToBounds = true
        parentView.layer.masksToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let parentView = superview {
            gradient.frame = parentView.bounds
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeFromSuperlayer()
    }
}

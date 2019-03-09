//
//  UIView+Additions.swift
//  anicoubs
//
//  Created by Holofox on 26.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

// MARK: Rotate UIView

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
}

// MARK: Refactoring UIColor

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

// MARK: Auto Layout Constraint

extension UIView {
    
    enum ConstraintType {
        case top, leading, trailing, bottom, width, height
    }
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> [ConstraintType : NSLayoutConstraint] {
        
        // Translate the view's autoresizing mask into Auto Layout constraints
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [ConstraintType : NSLayoutConstraint] = [:]
        
        if let top = top {
            constraints[.top] = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            constraints[.leading] = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            constraints[.bottom] = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            constraints[.trailing] = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            constraints[.width] = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            constraints[.height] = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        let constraintsArray = Array<NSLayoutConstraint>(constraints.values)
        NSLayoutConstraint.activate(constraintsArray)
        
        return constraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        
        // Translate the view's autoresizing mask into Auto Layout constraints
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [ConstraintType : NSLayoutConstraint] = [:]
        
        if let superviewTopAnchor = superview?.topAnchor {
            constraints[.top] = topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top)
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            constraints[.bottom] = bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom)
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            constraints[.leading] = leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left)
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            constraints[.trailing] = trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right)
        }
        
        let constraintsArray = Array<NSLayoutConstraint>(constraints.values)
        NSLayoutConstraint.activate(constraintsArray)
        
    }
    
}

// MARK: Applying gradient to the UIView
// https://stackoverflow.com/a/44968900/4636541
// By @Vasily Bodnarchuk

extension UIView {
    func addGradient(colors: [UIColor], locations: [NSNumber]) {
        addSubview(ViewWithGradient(addTo: self, colors: colors, locations: locations))
    }
}

// MARK: Getting actual number of lines of UILabel
// https://stackoverflow.com/a/48795672/4636541
// By @Kurt J

extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}

// MARK: Registering UITableView cells in a loop through string values
// https://stackoverflow.com/a/54698031/4636541
// By @DronPop

extension UITableView {
    
    func registerCells(_ types: [(AnyObject.Type, String)]) {
        for (type, identifier) in types {
            self.register(type, forCellReuseIdentifier: identifier)
        }
    }
    
    func registerHeaderFooterViews(_ types: [(AnyObject.Type, String)]) {
        for (type, identifier) in types {
            self.register(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
}

// MARK: UISegmentedControl change number of segments
// https://stackoverflow.com/a/34070197/4636541
// By @kernelpanic

extension UISegmentedControl {
    func replaceSegments(segments: [String]) {
        self.removeAllSegments()
        for segment in segments {
            self.insertSegment(withTitle: segment, at: self.numberOfSegments, animated: false)
        }
    }
}

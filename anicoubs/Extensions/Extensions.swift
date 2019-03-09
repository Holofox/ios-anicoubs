//
//  Extensions.swift
//  anicoubs
//
//  Created by Holofox on 22.01.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}

// MARK: Hyperlinks in a UITextView
// https://stackoverflow.com/a/53763712
// By @splangi

extension NSAttributedString {
    func replace(placeholder: String, with hyperlink: String, url: String) -> NSAttributedString {
        let mutableAttr = NSMutableAttributedString(attributedString: self)
        
        let hyperlinkAttr = NSAttributedString(string: hyperlink, attributes: [NSAttributedString.Key.link: URL(string: url)!])
        
        let placeholderRange = (self.string as NSString).range(of: placeholder)
        
        mutableAttr.replaceCharacters(in: placeholderRange, with: hyperlinkAttr)
        return mutableAttr
    }
}

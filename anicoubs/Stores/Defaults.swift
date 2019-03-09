//
//  UserDefaults.swift
//  anicoubs
//
//  Created by Holofox on 21.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import Foundation

class ReadingPreference: Codable {
    var fontName: String
    var fontSize: Float
    var darkMode: Bool
    
    init(fontName: String, fontSize: Float, darkMode: Bool) {
        self.fontName = fontName
        self.fontSize = fontSize
        self.darkMode = darkMode
    }
}

class PostPreference: Codable {
    
    var link: String
    var category: Int
    var postponed: Bool
    var date: Date
    
    init(link: String, category: Int, postponed: Bool, date: Date) {
        self.link = link
        self.category = category
        self.postponed = postponed
        self.date = date
    }
}


struct Defaults {
    
    struct Post {
        static let (postponedKey, dateKey) = ("postponed", "date")
        
        static var savePostponed = { (isOn: Bool) in
            UserDefaults.standard.set(isOn, forKey: postponedKey)
        }
        
        static var saveDate = { (date: Date) in
            UserDefaults.standard.set(date, forKey: dateKey)
        }

        static var getDate = {
            return UserDefaults.standard.object(forKey: dateKey) as? Date
        }
        
        static var getPostponed = {
            return UserDefaults.standard.bool(forKey: postponedKey)
        }
        
    }
    
}

//
//  VKDelegate.swift
//  anicoubs
//
//  Created by Holofox on 23.01.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import SwiftyVK
import UIKit

class VKDelegate: SwiftyVKDelegate {
    let appId = "5614612"
    let scope: Scopes = [.wall, .video, .offline]
    
    init() {
        VK.setUp(appId: appId, delegate: self)
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scope
    }
    
    func vkNeedToPresent(viewController: VKViewController) {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            rootController.present(viewController, animated: true)
        }
    }
    
    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        print("Token created in session \(sessionId) with info \(info)")
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("Token updated in session \(sessionId) with info \(info)")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("Token removed in session \(sessionId)")
    }
}

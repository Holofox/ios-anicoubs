//
//  TabBarController.swift
//  anicoubs
//
//  Created by Holofox on 22.01.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
     // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createDummyNavControllerWithTitle(viewController: HomeCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Home", imageName: "home"),
            createDummyNavControllerWithTitle(viewController: UIViewController(), title: "Timeline", imageName: "fire"),
            createDummyNavControllerWithTitle(viewController: UIViewController(), title: "Notifications", imageName: "notification"),
            createDummyNavControllerWithTitle(viewController: UIViewController(), title: "Settings", imageName: "settings")
        ]
        
        view.backgroundColor = Color.backgroundColor
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.clipsToBounds = true
        tabBar.tintColor = .black
    }
    
    private func createDummyNavControllerWithTitle(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: viewController)
            navController.tabBarItem.title = title
            navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
    }
    
}


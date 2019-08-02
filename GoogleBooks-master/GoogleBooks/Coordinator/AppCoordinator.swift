//
//  AppCoordinator.swift
//  GoogleBooks
//
//  Created by Jerry Zhou on 8/1/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let rootVC: UITabBarController
    
    init(with window: UIWindow) {
        self.window = window
        self.rootVC = UITabBarController()
    }
    
    func start() {
        let navMainVC = UINavigationController()
        let navFavoriteVC = UINavigationController()
        navMainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        navFavoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let mainVC = MainViewController.instantiate()
        let favoriteVC = FavoriteViewController.instantiate()
        
        navMainVC.pushViewController(mainVC, animated: true)
        navFavoriteVC.pushViewController(favoriteVC, animated: true)
        self.rootVC.viewControllers = [navMainVC, navFavoriteVC]
        
        self.window.rootViewController = self.rootVC
        self.window.makeKeyAndVisible()
    }
    
    
}

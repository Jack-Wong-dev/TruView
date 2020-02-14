//
//  TabBarController.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .orange
        let listingsVC = ListingsVC()
        let savedVC = SavedVC()
        let profileVC = ProfileVC()
      
      listingsVC.tabBarItem = UITabBarItem(title: "Listings", image: UIImage(systemName: "house"), tag: 0)
      savedVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "bookmark"), tag: 1)
      profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
      self.viewControllers = [listingsVC, savedVC, profileVC]
    }

}

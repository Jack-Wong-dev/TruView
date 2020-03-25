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
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        tabBar.unselectedItemTintColor = .systemFill
        let listingsVC = ListingsVC()
        let savedVC = SavedVC()
        let profileVC = ProfileVC()
      
      listingsVC.tabBarItem = UITabBarItem(title: "Listings", image: UIImage(systemName: "house"), tag: 0)
      savedVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "bookmark"), tag: 1)
      profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
      self.viewControllers = [listingsVC, savedVC, profileVC]
    }

}

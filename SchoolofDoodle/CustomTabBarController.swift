//
//  CustomTabBarController.swift
//  SchoolofDoodle
//
//  Created by Hannah Scott '17 on 7/20/16.
//  Copyright © 2016 Hannah Scott '17. All rights reserved.
//

import UIKit
import Firebase

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = UINavigationController(rootViewController: MessagesController())
        navigationBar.title = "Home"
        navigationBar.tabBarItem.image = UIImage(named: "Home")
    
        let secondNavigationController = UINavigationController(rootViewController: NewMessageController())
        secondNavigationController.title = "Messages"
        secondNavigationController.tabBarItem.image = UIImage(named: "NewMessage")
        
        let thirdNavigationController = UINavigationController(rootViewController: MyProfileController())
        thirdNavigationController.title = "My Profile"
        thirdNavigationController.tabBarItem.image = UIImage(named: "User")
        
        let fourthNavigationController = UINavigationController(rootViewController: AboutPageController())
        fourthNavigationController.title = "About"
        fourthNavigationController.tabBarItem.image = UIImage(named: "About")
            
        viewControllers = [navigationBar, thirdNavigationController, secondNavigationController, fourthNavigationController]
    }
}

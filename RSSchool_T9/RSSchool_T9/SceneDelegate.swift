//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: Uladzislau Volchyk
// On: 23.07.21
//
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let mainTabBarController = MainTabBarController()
        let mainVC = MainViewController()
        mainVC.title = "Items"
        let navVC = MainNavigationController()
        navVC.title = "Settings"
        let secVC = SecondaryViewController()
        secVC.title = "Settings"
        mainTabBarController.viewControllers = [mainVC, navVC]
        //mainVC.tabBarItem.standardAppearance(
        mainVC.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        secVC.tabBarItem.image = UIImage(systemName: "gear")
        navVC.viewControllers = [secVC]
        UITabBar.appearance().tintColor = UIColor.red
        UINavigationBar.appearance().tintColor = UIColor.red
        guard let winScene = scene as? UIWindowScene else {
            fatalError("LOL, be careful, drink some water")
        }
        window = UIWindow(windowScene: winScene)
        window?.rootViewController = mainTabBarController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}


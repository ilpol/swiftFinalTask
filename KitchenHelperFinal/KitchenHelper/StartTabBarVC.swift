//
//  StartTabBarVC.swift
//  KitchenHelper
//
//  Created by dfg on 13.11.2022.
//

import UIKit

class StartTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        if #available(iOS 13.0, *) {
            tabBar.tintColor = .label
        } else {
            // Fallback on earlier versions
        }
        setupVCs()
    }
    
    func setupVCs() {
        if #available(iOS 13.0, *) {
            viewControllers = [
                createNavController(for: RecepiesCategoriesViewController(), title: NSLocalizedString("Рецепты", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
                createNavController(for: FridgeViewController(), title: NSLocalizedString("Холодильник", comment: ""), image: UIImage(systemName: "house")!),
                createNavController(for: StoveViewController(), title: NSLocalizedString("Плита", comment: ""), image: UIImage(systemName: "person")!),
            ]
        } else {
            // Fallback on earlier versions
        }
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
 }

//
//  TabBarController.swift
//  SushiHub
//
//  Created by Babayev Kamran on 30.06.23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create view controllers for each tab
        let sushiCollectionVC = SushiCollectionViewController()
        let stepByStepVC = SushiSelectionViewController()

        let sushiCollectionNavVC = UINavigationController(rootViewController: sushiCollectionVC)
        let stepByStepNavVC = UINavigationController(rootViewController: stepByStepVC)


        sushiCollectionNavVC.tabBarItem = UITabBarItem(title: "Sushi Types", image: UIImage(systemName: "fork.knife"), tag: 0)
        stepByStepNavVC.tabBarItem = UITabBarItem(title: "Sushi Ingredients", image: UIImage(systemName: "tray.full.fill"), tag: 0)

        self.viewControllers = [sushiCollectionNavVC, stepByStepNavVC]
    }

}

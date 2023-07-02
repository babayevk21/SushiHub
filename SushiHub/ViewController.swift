//
//  ViewController.swift
//  SushiHub
//
//  Created by Babayev Kamran on 30.06.23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTabBar()
    }
    
    func showTabBar() {
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: false)
    }

}


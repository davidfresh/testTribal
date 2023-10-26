//
//  MainViewController.swift
//  Test
//
//  Created by David on 26/10/23.
//

import UIKit
class MainViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addInitialViewController()
        setNavigationBar()
    }
}

private extension MainViewController {
    func addInitialViewController() {
        let initialViewController = ListJokeViewController()
        viewControllers = [initialViewController]
    }
    
    func setNavigationBar() {
        navigationBar.prefersLargeTitles = false
        navigationBar.isTranslucent = false
        navigationItem.largeTitleDisplayMode = .automatic
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
            navigationBar.barTintColor = .white
            navigationBar.shadowImage = UIImage()
        }
    }
}

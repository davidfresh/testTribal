//
//  BaseViewController.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation
import UIKit

typealias AlertAction = ((UIAlertAction) -> Void)?

class BaseViewController: UIViewController {
    
    private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarColors()
    }
    
    func setActivityIndicator(_ activityIndicator: UIActivityIndicatorView!) {
        self.activityIndicator = activityIndicator
    }
    
    func setBackButton(action: Selector?) {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.hidesBackButton = false
    }
    
    func setRightButtonWithItem(_ item: UIBarButtonItem) {
        navigationItem.rightBarButtonItem = item
    }
    
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
    }
    
    func showAlertView(error: String, didTapActionButton: AlertAction) {
        let alert = UIAlertController(title: Localizable.alertTitleError.localized,
                                      message: error,
                                      preferredStyle: .alert)
        let actionButton = UIAlertAction(title:Localizable.alertButtonOK.localized,
                                         style: .default,
                                         handler: didTapActionButton)
        alert.addAction(actionButton)
        present(alert, animated: true, completion: nil)
    }
}

private extension BaseViewController {
    func setNavigationBarColors() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
}

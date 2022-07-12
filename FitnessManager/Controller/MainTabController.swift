//
//  MainTabController.swift
//  FitnessManager
//
//  Created by Алишер Ахметжанов on 18.05.2022.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    //MARK: свойства
    
    let actionButton:UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .fitGrey
        button.backgroundColor = .white
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()

    //MARK: - жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //logUserOut()
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - API
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil )
            }
        } else {
            configureViewControllers()
            configureUI()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with Error \(error.localizedDescription)")
        }
    }
    
    // selectors
    
    @objc func actionButtonTapped() {
        print("correct")
    }
    
    //MARK: хелперс
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureViewControllers() {
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let chat = ChatViewController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: chat)
        
        
        viewControllers = [nav1, nav4]
    }
    
    func templateNavigationController(image:UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
}


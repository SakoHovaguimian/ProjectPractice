//
//  ViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/10/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

var TAB_BAR_HEIGHT = 0
var NAV_BAR_HIEGHT = 0

import UIKit

// MARK:TODO: CREATE TAB FOR DISPLAYING RECORDING SOUND / WAVES
// MARK:TODO: CREATE MODEL FOR SOUND CELLS
// MARK:TODO: CREATE HASHTAGS AS PARENT -> CHILD = [SOUND_MODEL]


class TabBarController: UITabBarController {
    
    private var line: UIView = {
        let vw = UIView()
        vw.backgroundColor = .black
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTabBarItems()
        self.configureLine()
        self.setupNotifications()
        
        TAB_BAR_HEIGHT = Int(self.tabBarController?.tabBar.frame.height ?? 39.0)
        NAV_BAR_HIEGHT = Int(self.navigationController?.navigationBar.frame.height ?? 39.0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func configureTabBarItems() {
        
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.tintColor = .black
        
        let homeNav = self.templateNavigationController(title: "Home", image: "house", tag: 0, viewController: HomeViewController())
        
        let shopNav = self.templateNavigationController(title: "Shop", image: "magnifyingglass", tag: 1, viewController: ShopViewController())
        
        let profileNav = self.templateNavigationController(title: "Profile", image: "person.circle", tag: 2, viewController: ProfileViewController())
        
        self.viewControllers = [homeNav, shopNav, profileNav]
        
    }
    
    private func templateNavigationController(title: String, image: String, tag: Int, viewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.tag = tag
        nav.tabBarItem.image = UIImage(systemName: image)
        nav.navigationBar.barTintColor = .white
        return nav
        
    }
    
    private func configureLine() {
        
        self.view.addSubview(self.line)
        
        self.line.addShadow(shadow: .black, opacity: 0.5, offSet: CGSize(width: 0, height: 1), raidus: 0.5)

        self.line.setDimmensions(height: 2, width: self.view.frame.width / 3)
        self.line.anchor(left: self.view.leftAnchor, bottom: self.tabBar.topAnchor, paddingBottom: 0)
        
    }
    
    private func animateLine(index: Int) {
        
        let xposition = (self.tabBar.getFrameForTabAt(index: index)?.origin.x)!
           UIView.animate(withDuration: 0.3) {
                self.line.frame.origin.x = xposition
        }
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        self.animateLine(index: item.tag)
    
    }
    
    private func setupNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.testNotification), name: .testNotification, object: nil)
        
    }
    
    @objc private func testNotification(_ notification: NSNotification) {
        
        if let _ = notification.object as? [String : String] {
            
        }
        
    }

}


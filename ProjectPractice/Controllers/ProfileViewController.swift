//
//  ProfileViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/10/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class ProfileViewController: UIViewController {
    
    private var profileHeaderView: ProfileTableHeaderView?
    
    private let user = User.fakeDataUsers().randomElement()!
    
    private lazy var profileTableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.clipsToBounds = true
        tv.backgroundColor = .clear
        tv.isUserInteractionEnabled = true
        tv.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.identifier)
        tv.register(UINib(nibName: ProfileTableHeaderView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProfileTableHeaderView.identifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.configureViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupNavBar()
        
    }
    
    private func setupNavBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureViews() {
        
        self.view.addSubview(self.profileTableView)
        
        self.profileTableView.anchor(top: self.view.topAnchor,
                                     left: self.view.leftAnchor,
                                     bottom: self.view.bottomAnchor,
                                     right: self.view.rightAnchor,
                                     paddingTop: -30,
                                     paddingBottom: 85)
        
    }
    
    private func fetchRandomUser() -> User {
        return User.fakeDataUsers().randomElement()!
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.profileTableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell {
            
            cell.value = "Home Page"
            cell.textLabel?.textColor = .white
            
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = ["name": "Sako Hovaguimian"]
        NotificationCenter.default.post(name: .testNotification, object: object)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        self.profileHeaderView = (self.profileTableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableHeaderView.identifier) as! ProfileTableHeaderView)
        
        self.profileHeaderView?.delegate = self
        self.profileHeaderView?.user = self.user
        
        return self.profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240
    }
    
}

extension ProfileViewController: DoSomethingWhenPressedDelegate {
    
    func handleImageViewTapped() {
        logDebugMessage("ImageView Tapped. Select Image")
    }
    
    func handleInstagramButtonTapped() {
        logDebugMessage("Instagram Button Tapped")
        self.openInstagram(instagramHandle: String(self.user.instagramHandle.dropFirst()))
    }
    
    func handleEditProfileButtonTapped() {
        logDebugMessage("Edit Profile Tapped")
    }
    
    func handleSettingsButtonTapped() {
        logDebugMessage("Settings Button Tapped")
    }
    
}

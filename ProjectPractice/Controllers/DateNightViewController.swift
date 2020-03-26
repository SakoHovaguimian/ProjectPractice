//
//  DateNightViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class DateNightViewController: UIViewController {
    
    private lazy var datingTableView: UITableView = {
        self.configureTableView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureViews()
        
    }
    
    private func configureViews() {
        
        self.navigationItem.title = "EAT"
        
        self.view.addSubview(self.datingTableView)
        
        self.datingTableView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor)

        
    }
    
    private func configureTableView() -> UITableView {
        
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.clipsToBounds = true
        tv.backgroundColor = .OFF_WHITE
        tv.isUserInteractionEnabled = true
        tv.register(UINib(nibName: YelpTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: YelpTableViewCell.identifier)
//        tv.register(UINib(nibName: ProfileTableHeaderView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProfileTableHeaderView.identifier)
        return tv
        
    }

}

extension DateNightViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.datingTableView.dequeueReusableCell(withIdentifier: YelpTableViewCell.identifier, for: indexPath) as? YelpTableViewCell {
            
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = ["name": "Sako Hovaguimian"]
        NotificationCenter.default.post(name: .testNotification, object: object)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
}

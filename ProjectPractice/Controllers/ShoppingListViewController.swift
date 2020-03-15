//
//  ShoppingListViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .ISABELLINE
        
        self.setupNavBar()
        
    }
    
    private func setupNavBar() {
        
        self.navigationItem.title = "SHOPPING LIST"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Shopping", style: .plain, target: nil, action: nil)
        
    }

    
}



//
//  CustomViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    init(backButtonName: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: backButtonName, style: .plain, target: nil, action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

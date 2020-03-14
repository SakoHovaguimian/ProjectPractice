//
//  HomeTableViewCell.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    public var value: String? {
        didSet {
            self.configure()
        }
    }

    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.setupViews()
        
    }
    
    private func setupViews() {
        
        self.containerView.layer.cornerRadius = 23
        self.containerView.backgroundColor = .ISABELLINE
        
        self.textLabel?.textAlignment = .center
        self.textLabel?.textColor = .white
        
    }
    
    private func configure() {
        
        self.textLabel?.text = value
        
    }
    
}

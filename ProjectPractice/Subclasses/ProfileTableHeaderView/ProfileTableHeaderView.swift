//
//  ProfileTableHeaderView.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class ProfileTableHeaderView: UIView {
    
    static let identifier = "ProfileTableHeaderView"

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    init(user: User, frame: CGRect) {
        
        super.init(frame: frame)
        
        self.configure(user: user)
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(user: User) {
        
        Bundle.main.loadNibNamed(ProfileTableHeaderView.identifier, owner: self, options: nil)
        
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.profileImageView.clipsToBounds = true
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.layer.cornerRadius = 50 / 2
        
        self.nameLabel.text = user.name
        self.descriptionLabel.text = user.decription

    }
    
    
}

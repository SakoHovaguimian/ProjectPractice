//
//  ProfileTableHeaderView.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

protocol DoSomethingWhenPressedDelegate: class {
    func handleAction()
}

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "ProfileTableHeaderView"
    
    weak var delegate: DoSomethingWhenPressedDelegate!
    
    var user: User? {
        didSet {
            self.configure(user: self.user!)
        }
    }

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func configure(user: User) {
        
        Bundle.main.loadNibNamed(ProfileTableHeaderView.identifier, owner: self, options: nil)
        
        self.profileImageView.clipsToBounds = true
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.layer.cornerRadius = 50 / 2
        self.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.profileImageView.addGestureRecognizer(tap)
        self.profileImageView.isUserInteractionEnabled = true
        
        self.nameLabel.text = user.name
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionLabel.text = user.decription
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false


    }
    
   @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.delegate.handleAction()
    }
    

}

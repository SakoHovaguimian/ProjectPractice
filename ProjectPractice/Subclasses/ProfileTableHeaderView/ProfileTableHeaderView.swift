//
//  ProfileTableHeaderView.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

protocol DoSomethingWhenPressedDelegate: class {
    func handleImageViewTapped()
    func handleInstagramButtonTapped()
    func handleEditProfileButtonTapped()
    func handleSettingsButtonTapped()
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
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var profileStackView: UIStackView!
    
    
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
        self.profileImageView.layer.cornerRadius = 5
        self.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleImageViewTapped(_:)))
        self.profileImageView.addGestureRecognizer(tap)
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.image = self.user?.image
        
        self.nameLabel.text = user.name
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionLabel.text = user.decription
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.instagramButton.setTitleColor(.ROYAL_PURPLE, for: .normal)
        self.instagramButton.addTarget(self, action: #selector(self.handleInstagramButtonTapped(sender:)), for: .touchUpInside)

        self.editProfileButton.layer.borderWidth = 1.0
        self.editProfileButton.layer.borderColor = UIColor.ROYAL_PURPLE?.cgColor
        self.editProfileButton.setTitleColor(.ROYAL_PURPLE, for: .normal)
        self.editProfileButton.layer.cornerRadius = 3
        self.editProfileButton.addTarget(self, action: #selector(self.handleEditProfileButtonTapped(sender:)), for: .touchUpInside)

        self.updateStackView()
        
        self.instagramButton.setTitle(self.user?.instagramHandle, for: .normal)
        
        self.settingsButton.tintColor = .ROYAL_PURPLE
        self.settingsButton.addTarget(self, action: #selector(self.handleSettingsButtonTapped(sender:)), for: .touchUpInside)
        self.settingsButton.setImage(UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
    }
    
    private func updateStackView() {
        
        let fillerView = UIView()
        let viewToInsert = (self.user?.instagramHandle != "" ? self.instagramButton : fillerView)!

        self.profileStackView.addArrangedSubview(viewToInsert)
        self.instagramButton.isHidden = self.user?.instagramHandle != "" ? false : true

    }
    
   @objc private func handleImageViewTapped(_ sender: UITapGestureRecognizer? = nil) {
        self.delegate.handleImageViewTapped()
    }
    
    @objc private func handleInstagramButtonTapped(sender: UIButton) {
        self.delegate.handleInstagramButtonTapped()
    }
    
    @objc private func handleEditProfileButtonTapped(sender: UIButton) {
        self.delegate.handleEditProfileButtonTapped()
    }
    
    @objc private func handleSettingsButtonTapped(sender: UIButton) {
        self.delegate.handleSettingsButtonTapped()
    }

}

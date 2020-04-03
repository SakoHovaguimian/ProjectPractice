//
//  YelpTableViewCell.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/25/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Kingfisher

class YelpTableViewCell: UITableViewCell {
    
    private var business: Business!
    
    static let identifier = "YelpTableViewCell"
    
    //MARK:- Create Object & Configure Function
    
    @IBOutlet weak var yelpImageView: UIImageView!
    @IBOutlet weak var yelpContentView: UIView!
    @IBOutlet weak var yelpTitleLabel: UILabel!
    @IBOutlet weak var yelpDetailLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var yelpStackView: UIStackView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureViews()
        
    }
    
    private func configureViews() {
        
        self.yelpImageView.clipsToBounds = true
        self.yelpImageView.layer.cornerRadius = 7
        
        self.yelpContentView.clipsToBounds = true
        self.yelpContentView.layer.cornerRadius = 7
    
        self.yelpContentView.backgroundColor = .white
        self.yelpContentView.addShadow(shadow: .black, opacity: 0.5, offSet: CGSize.zero, raidus: 2.0)
        
        self.lineView.backgroundColor = .ISABELLINE
        
        self.yelpStackView.addArrangedSubview(RatingView())
        self.yelpStackView.addArrangedSubview(RatingView())
        self.yelpStackView.addArrangedSubview(RatingView())
        
    }
    
    public func configureCell(withBusiness business: Business) {
        
        self.business = business
        
        self.yelpTitleLabel.text = self.business.name
        self.yelpDetailLabel.text = self.business.id
        self.yelpDetailLabel.text = self.business.categories.map({ $0.title }).joined(separator: ", ")
        
        if let url = URL(string: self.business.imageURL) {
            self.yelpImageView.kf.setImage(with: url)
        }
        
        if let ratingsViews = self.yelpStackView.arrangedSubviews as? [RatingView] {
            
            let customView1 = ratingsViews[0]
            customView1.imageView.image = #imageLiteral(resourceName: "dish")
            customView1.textLabel.text = "\(self.business.rating ?? 0.0)"
            
            let customView2 = ratingsViews[1]
            customView2.imageView.image = #imageLiteral(resourceName: "date")
            customView2.textLabel.text = "\(self.business.reviewCount)"

            let customView3 = ratingsViews[2]
            customView3.imageView.image = #imageLiteral(resourceName: "settings")
            customView3.textLabel.text = "\(self.business.price ?? "")"
            
        }
        
    }
    
}

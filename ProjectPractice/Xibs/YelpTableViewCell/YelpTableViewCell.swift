//
//  YelpTableViewCell.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/25/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class YelpTableViewCell: UITableViewCell {
    
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
        self.loadMochData()
        
    }
    
    private func configureViews() {
        
        self.yelpImageView.clipsToBounds = true
        self.yelpImageView.layer.cornerRadius = 7
        
        self.yelpContentView.clipsToBounds = true
        self.yelpContentView.layer.cornerRadius = 7
        
        self.yelpContentView.backgroundColor = .white
        self.yelpContentView.addShadow(shadow: .black, opacity: 0.5, offSet: CGSize.zero, raidus: 2.0)
        
        self.lineView.backgroundColor = .ISABELLINE
        
    }
    
    private func loadMochData() {
        
        self.yelpTitleLabel.text = "Sako's Dank Dick"
        self.yelpDetailLabel.text = "Pizza, Italian, Fast Food"
        
        //MARK:- Update After we have object data
        
        let customView1 = RatingView()

        let customView2 = RatingView()
        customView2.imageView.image = #imageLiteral(resourceName: "date")

        let customView3 = RatingView()
        customView1.imageView.image = #imageLiteral(resourceName: "settings")
        
        
        self.yelpStackView.addArrangedSubview(customView1)
        self.yelpStackView.addArrangedSubview(customView2)
        self.yelpStackView.addArrangedSubview(customView3)
        
    }
    
}

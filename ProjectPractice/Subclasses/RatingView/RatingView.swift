//
//  RatingView.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/25/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class RatingView: UIView {
    
    static let identifier = "RatingView"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    init(name: String, image: UIImage) {
        super.init(frame: CGRect.zero)
        self.textLabel.text = name
        self.imageView.image = image
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {

        Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    

}

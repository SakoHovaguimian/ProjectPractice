//
//  Cuisine.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class Cuisine {
    
    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    var image: UIImage? {
        return UIImage(named: imageName)
    }
    
    static func generateFakeCuisine() -> Cuisine {
        
        let cusines = [
            Cuisine(name: "Chinese", imageName: "chinese"),
            Cuisine(name: "Italian", imageName: "italian"),
            Cuisine(name: "Middle Eastern", imageName: "middle_eastern")
        ]
        
        return cusines.randomElement()!
        
    }
    
}

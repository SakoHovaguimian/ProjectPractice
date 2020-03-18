//
//  Recipe.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/17/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class Recipe {
    
    var name: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    static func generateFakeRecipe() -> Recipe {
        return Recipe(name: "kung poa chicken", image: UIImage(named: "chinese")!)
    }
    
}

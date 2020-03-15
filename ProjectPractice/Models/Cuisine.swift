//
//  Cuisine.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

enum CuisineChoices: String, CaseIterable {
    
    case italian
    case middleEastern
    case chinese
    case american
    case japanese
    case dessert
    
    var description: String {
        
        switch self {
        case .italian: return "Italian"
        case .middleEastern: return "Middle Eastern"
        case .chinese: return "Chinese"
        case .american: return "American"
        case .japanese: return "Japanese"
        case .dessert: return "Dessert"
        }
        
    }
    
}

class Cuisine {
    
    var name: String
    var imageName: String
    
    init(name: CuisineChoices, imageName: String) {
        self.name = name.description
        self.imageName = imageName
    }
    
    var image: UIImage? {
        return UIImage(named: imageName)
    }
    
    static func generateFakeCuisines() -> [Cuisine] {
        
        let cusines = [
            Cuisine(name: .chinese, imageName: "chinese"),
            Cuisine(name: .italian, imageName: "italian"),
            Cuisine(name: .middleEastern, imageName: "middle_eastern"),
            Cuisine(name: .american, imageName: "american"),
            Cuisine(name: .japanese, imageName: "japanese"),
            Cuisine(name: .dessert, imageName: "dessert"),
        ]
        
        return cusines
        
    }
    
}

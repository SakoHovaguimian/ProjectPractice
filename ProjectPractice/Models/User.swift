//
//  File.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class User {
    
    var name: String
    var decription: String
    var imageName: String
    var instagramHandle: String = ""
    
    init(name: String, decription: String, imageName: String, instagramHandle: String? = nil) {
        self.name = name
        self.decription = decription
        self.imageName = imageName
        
        if let instagramName = instagramHandle {
            self.instagramHandle = instagramName
        }
    }
    
    var image: UIImage? {
        return UIImage(named: self.imageName)
    }
    
    static func fakeDataUsers() -> [User] {
        let users = [
                      User(name: "Sako Hovaguimain",
                           decription: "Developer. Burger Man. Pokemon Master. Ex-cited to be here.",
                           imageName: "boy1"),
                      User(name: "Chelsea Eichler",
                           decription: "LVN -> RN | I love my manly man @SakoTaco",
                           imageName: "girl1",
                           instagramHandle: "@chelsfveichler"),
                      User(name: "Sammy Hovaguimain",
                           decription: "I'm going to hit this mudder fuckker with that mudder fuckker",
                           imageName: "boy2"),
                      User(name: "Lauren Conrad",
                           decription: "Animal Rights // Makeup // Yugioh Dreamer",
                           imageName: "girl2",
                           instagramHandle: "@theLaurenConrad")
                    ]
        
        return users
    }
    
}

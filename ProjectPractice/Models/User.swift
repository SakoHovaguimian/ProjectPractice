//
//  File.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var decription: String
    
    init(name: String, decription: String) {
        self.name = name
        self.decription = decription
    }
    
    static func fakeDataUsers() -> [User] {
        let users = [User(name: "Tom Hanks",
                           decription: "This is something that is nothing, This is developer"),
                      User(name: "Sako Hovaguimain",
                           decription: "This is something that is nothing, This is developer"),
                      User(name: "Chelsea Eichler",
                            decription: "This is something that is nothing, This is developer"),
                      User(name: "Sammy Hovaguimain",
                            decription: "This is something that is nothing, This is developer")
        ]
        
        return users
    }
    
}

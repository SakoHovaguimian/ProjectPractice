//
//  YelpService.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 4/1/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Alamofire

class YelpService {
    
    enum Endpoint: String {
        
        case searchBusinesses = "/businesses/search"
        case searchABusiness = "/businesses"
        
        
        func url(_ base: String, id: String = "") -> URL? {
            let businessToSearchId = id == "" ? "" : "/\(id)"
            return URL(string: base + self.rawValue + businessToSearchId)
        }
        
    }
    
    static func fetchRestaurants(completion: @escaping ([Business]?, Error?) -> ()) {
        
        guard let url = Endpoint.searchBusinesses.url(yelpBaseURL) else { return }
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer " + apiKey
        ]
        
        let params: [String : Any] = [
            "term": "Burgers",
            "offset": 0,
            "limit": 50,
            "longitude": -117.901850,
            "latitude": 33.602290
        ]

        AF.request(url, parameters: params, headers: headers)
            .validate()
            .responseDecodable(of: Businesses.self) { (response) in
            
                guard let businesses = response.value else { completion(nil, response.error); return }
                completion(businesses.businesses, nil)
                
        }
        
    }
    
}



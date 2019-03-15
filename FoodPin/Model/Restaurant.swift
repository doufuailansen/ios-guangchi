//
//  Restaurant.swift
//  FoodPin
//
//  Created by Apple on 2018/8/3.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String = ""
    var type: String
    var location: String
    var phone: String
    var address: String
    var description: String
    var image: String
    var isVisited: Bool
    var rating: String
    
    init(name: String, type: String, location: String, phone: String, address: String, description: String, image: String, isVisited: Bool, rating: String) {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.address = address
        self.description = description
        self.image = image
        self.isVisited = isVisited
        self.rating = rating
    }
    
    convenience init() {
        self.init(name: "", type: "", location: "", phone: "", address: "", description: "", image: "", isVisited: false, rating: "")
    }
}

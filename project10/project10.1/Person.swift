//
//  Person.swift
//  project10.1
//
//  Created by Ainura Kerimkulova on 9/3/22.
//

import UIKit

class Person: NSObject, Codable{
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    

}

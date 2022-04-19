//
//  Person.swift
//  project10over
//
//  Created by Ainura Kerimkulova on 31/3/22.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String){
        self.name = name
        self.image = image
    }
}

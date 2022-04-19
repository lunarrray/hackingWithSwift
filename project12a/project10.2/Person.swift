//
//  Person.swift
//  project10.2
//
//  Created by Ainura Kerimkulova on 9/3/22.
//

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init(coder aCoder: NSCoder){
        name = aCoder.decodeObject(forKey: "name") as? String ?? ""
        image = aCoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
}

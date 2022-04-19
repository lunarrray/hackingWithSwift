//
//  Picture.swift
//  day50
//
//  Created by Ainura Kerimkulova on 19/3/22.
//

import UIKit

class Picture: NSObject, Codable {
    var imageName: String
    var caption: String
    
    init(imageName: String, caption: String){
        self.imageName = imageName
        self.caption = caption
    }
    
}

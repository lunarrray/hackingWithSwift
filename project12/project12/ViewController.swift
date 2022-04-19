//
//  ViewController.swift
//  project12
//
//  Created by Ainura Kerimkulova on 17/3/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set(true, forKey: "isWoman")
        
        defaults.set(Date(), forKey: "Date")
        defaults.set("Ainura", forKey: "Name")
        
        let array = ["London", "Paris", "Moscow"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Anna", "Age": 25, "isWomen": true] as [String : Any]
        defaults.set(dict, forKey: "SavedDict")
        
        let age = defaults.integer(forKey: "Age")
        let isWoman = defaults.bool(forKey: "isWoman")
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let savedDict = defaults.object(forKey: "SavedDict") as? [String: Any] ?? [String: Any]()
    }


}


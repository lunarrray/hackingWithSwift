//
//  ViewController.swift
//  icodeHomework1
//
//  Created by Ainura Kerimkulova on 10/3/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var sayHi: UILabel!
    @IBOutlet var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okTapped(_ sender: UIButton) {
        sayHi.isHidden = false
        slider.isHidden = false
        let name = textField?.text
        sayHi.text = "Hello, \(name!)"
        textField.text = ""
    }
    
    @IBAction func changeSizeOfLabel(_ sender: UISlider) {
        let size = CGFloat(sender.value)
        let fontName = sayHi.font.fontName
        sayHi.font = UIFont(name: fontName, size: size)
    }
    

}


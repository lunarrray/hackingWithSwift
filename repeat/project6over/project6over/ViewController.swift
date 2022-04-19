//
//  ViewController.swift
//  project6over
//
//  Created by Ainura Kerimkulova on 24/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = UIColor.white
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "These are our projcets"
        label1.textAlignment = .center
        label1.sizeToFit()
        
        view.addSubview(label1)
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.blue
        label2.text = "These are our projcets"
        label2.textAlignment = .center
        label2.sizeToFit()
        
        view.addSubview(label2)

        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.gray
        label3.text = "These are our projcets"
        label3.textAlignment = .center
        label3.sizeToFit()
        
        view.addSubview(label3)
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "These are our projcets"
        label4.textAlignment = .center
        label4.sizeToFit()
        
        view.addSubview(label4)
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.yellow
        label5.text = "These are our projcets"
        label5.textAlignment = .center
        label5.sizeToFit()
        
        view.addSubview(label5)
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            label1.widthAnchor.constraint(equalTo: view.widthAnchor),
            label1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5, constant: -50),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            label2.widthAnchor.constraint(equalTo: label1.widthAnchor),
            label2.heightAnchor.constraint(equalTo: label1.heightAnchor),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            label3.widthAnchor.constraint(equalTo: label1.widthAnchor),
            label3.heightAnchor.constraint(equalTo: label1.heightAnchor),
            
            label4.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 20),
            label4.widthAnchor.constraint(equalTo: label1.widthAnchor),
            label4.heightAnchor.constraint(equalTo: label1.heightAnchor),
            
            label5.topAnchor.constraint(equalTo: label4.bottomAnchor, constant: 20),
            label5.widthAnchor.constraint(equalTo: label1.widthAnchor),
            label5.heightAnchor.constraint(equalTo: label1.heightAnchor)
            
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    


}


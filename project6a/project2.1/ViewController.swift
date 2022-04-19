//
//  ViewController.swift
//  project2.1
//
//  Created by Ainura Kerimkulova on 3/2/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var track = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
        
        countries += ["estonia", "france",  "germany", "ireland", "italy", "monaco", "nigeria", "russia", "poland", "spain", "uk", "us"]
        
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased())"

    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        track += 1
        
        if track == 11 {
            track = 0
            title = "You finished the game"
            
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            track = 0
            score = 0
        }
        
        else{
        
            if sender.tag == correctAnswer{
                title = "Correct"
                score += 1
            }
            else{
                title = "You're fucking stupid peace of shit. That's the flag of \(countries[sender.tag].uppercased())"
                score -= 1
            }
        
            let ac = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
            present(ac, animated: true)
            
        }
        
    }
    
    @objc func showScore(){
        let vc = UIAlertController(title: "Score", message: "\(score)", preferredStyle: .alert)
        
        vc.addAction(UIAlertAction(title: "Continue", style: .default, handler: {(alert: UIAlertAction!) in print("")}))
        
        present(vc, animated: true)
    }
    
}


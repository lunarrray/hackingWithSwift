//
//  ViewController.swift
//  project2over
//
//  Created by Ainura Kerimkulova on 21/3/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    
    var countries = [String]()
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var correctAnswer = 0
    var track = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.gray.cgColor
        button2.layer.borderColor = UIColor.gray.cgColor
        button3.layer.borderColor = UIColor.gray.cgColor
        
        askQuestion()

    }
    
    func askQuestion(action: UIAlertAction! = nil){
        if track <= 3{
            
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        scoreLabel.text = "Score: \(score)"
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        track += 1
        
        }else{
            
            let defaults = UserDefaults.standard
            var scores = defaults.object(forKey: "scores") as? [Int] ?? [Int]()
            var highestScore = score
            for scoreItem in scores{
                if highestScore < scoreItem{
                    highestScore = scoreItem
                }
            }
            if score == highestScore{
                let ac = UIAlertController(title: "You bit your highest score. Congratulations!", message: "Your score is \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
                present(ac, animated: true)
            }else{
                let ac = UIAlertController(title: "You finished the game", message: "Your score is \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
                present(ac, animated: true)
            }
            
            
            scores.append(score)
            defaults.set(scores, forKey: "scores")
            score = 0
            track = 0
        }

    }
        
    @IBAction func buttonTapped(_ sender: UIButton) {
        let title: String
        var message: String?
        
        if sender.tag == correctAnswer{
            title = "Correct"
            message = nil
            score += 1
        }else{
            title = "Wrong"
            message = "It's flag of \(countries[sender.tag])"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    

}


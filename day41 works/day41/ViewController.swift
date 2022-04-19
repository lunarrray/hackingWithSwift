//
//  ViewController.swift
//  day41
//
//  Created by Ainura Kerimkulova on 2/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    var clueLabel: UILabel!
    var answerLabel: UILabel!
    var lifeLabel: UILabel!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    
    var clues = [String]()
    var solutions = [String]()
    var currentSolution = String()
    var letters = [String]()
    
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    var lives = 7{
        didSet{
            lifeLabel.text = "lives: \(lives)"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        lifeLabel = UILabel()
        lifeLabel.translatesAutoresizingMaskIntoConstraints = false
        lifeLabel.text = "Lives: 7"
        lifeLabel.textAlignment = .right
        view.addSubview(lifeLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = .left
        view.addSubview(scoreLabel)
        
        clueLabel = UILabel()
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.text = "CLUE"
        clueLabel.font = UIFont.systemFont(ofSize: 40)
        clueLabel.numberOfLines = 0
        clueLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        clueLabel.textAlignment = .center
        view.addSubview(clueLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.textAlignment = .center
        answerLabel.text = "ANSWER"
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answerLabel.font = UIFont.systemFont(ofSize: 64)
        view.addSubview(answerLabel)
        
        let newGame = UIButton(type: .system)
        newGame.translatesAutoresizingMaskIntoConstraints = false
        newGame.setTitle("New game", for: .normal)
        view.addSubview(newGame)
        
        let help = UIButton(type: .system)
        help.translatesAutoresizingMaskIntoConstraints = false
        help.setTitle("Help", for: .normal)
        view.addSubview(help)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
            
            lifeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            lifeLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            clueLabel.topAnchor.constraint(equalTo: lifeLabel.bottomAnchor, constant: 40),
            clueLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.8),
            clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            answerLabel.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 30),
            answerLabel.centerXAnchor.constraint(equalTo: clueLabel.centerXAnchor),
            answerLabel.widthAnchor.constraint(equalTo: clueLabel.widthAnchor),
            
            newGame.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 20),
            newGame.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            newGame.heightAnchor.constraint(equalToConstant: 44),
            
            help.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 20),
            help.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            help.centerYAnchor.constraint(equalTo: newGame.centerYAnchor),
            help.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.widthAnchor.constraint(equalToConstant: 900),
            buttonsView.heightAnchor.constraint(equalToConstant: 600)
            
            
        ])
        
        let width = 150
        let height = 120
        
        for row in 0..<5{
            for column in 0..<6{
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 34)
                letterButton.setTitle("W", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGame()
        
    }
    
    
    @objc func letterTapped(_ sender: UIButton){
        guard var progress = answerLabel?.text else{return}
        var indexes = [Int]()
        let arrSolution = Array(currentSolution)
        
        guard let letterString = sender.titleLabel?.text else{return}
        let letterCharacter = Character(letterString)
        
        if currentSolution.contains(letterCharacter){
            // print(currentSolution.firstIndex(of: letterCharacter)!)
            for i in 0..<arrSolution.count{
                if letterCharacter == arrSolution[i]{
                    indexes.append(i)
                }
            }
            var progressArr = Array(progress)
            for index in indexes{
                progressArr[index] = letterCharacter
            }
            progress = ""
            for item in progressArr{
                progress += String(item)
            }
            answerLabel.text = progress
            sender.isHidden = true
            
            if !progress.contains("?"){
                score += 1
                let ac = UIAlertController(title: "Congratulations! You win", message: "Ready for new challenge?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                //put here handler
                present(ac, animated: true)
            }
        } else{
            lives -= 1
            if lives == 0{
                let ac = UIAlertController(title: "You lost!", message: "Do you want to start a new game?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "New game", style: .default))
                //put here handler
                present(ac, animated: true)
            }
            
            let vc = UIAlertController(title: "Wrong letter", message: "You have \(lives) lives left", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Ok", style: .default))
            present(vc, animated:  true)
        }
        
    }
    
    func startGame(){
        // var clueString = ""
        var solutionString = ""
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let levelContents = try? String(contentsOf: levelFileURL){
                var lines = levelContents.components(separatedBy: "\n")
               // lines.shuffle()
                
                for ( _ ,line) in lines.enumerated(){
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    // clueString += clue
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutions.append(solutionWord)
                    clues.append(clue)
                    /* for _ in 0..<solutionWord.count{
                     solutionString += "?"
                     }*/
                }
            }
            
           // let random = Int.random(in: 0..<7)
            clueLabel.text = clues[score]
            
            currentSolution = solutions[score]
            let numOFLetters = solutions[score].count
            for _ in 0..<numOFLetters{
                solutionString += "?"
                answerLabel.text = solutionString
            }
            
        }
        if let lettersFileURL = Bundle.main.url(forResource: "letters", withExtension: "txt"){
            if let lettersContent = try? String(contentsOf: lettersFileURL){
                letters = lettersContent.components(separatedBy: "\n")
            }
            
            if letters.count == letterButtons.count{
                for i in 0..<letterButtons.count{
                    letterButtons[i].setTitle(letters[i].uppercased(), for: .normal)
                    if letters[i] == "."{
                        letterButtons[i].isHidden = true
                    }
                }
            }//else{
            // print(letters.count)
            //print(letterButtons.count)
            //}
        }//else{
        //   print("fail")
        //}
    }
    
    
}


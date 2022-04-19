//
//  ViewController.swift
//  day41challenge
//
//  Created by Ainura Kerimkulova on 29/3/22.
//

import UIKit

class ViewController: UIViewController {

    var lifesLabel: UILabel!
    var scoreLabel: UILabel!
    var clueLabel: UILabel!
    var answerLabel: UILabel!
    var letterButtons = [UIButton]()
    
    
    var lifes = 10{
        didSet{
            lifesLabel.text = "LIFES: \(lifes)"
        }
    }
    var score = 0{
        didSet{
            scoreLabel.text = "SCORE: \(score)"
        }
    }
    var clues = [String]()
    var answers = [String]()
    var currentAnswer: String?
    var activatedButtons = [UIButton]()
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        lifesLabel = UILabel()
        lifesLabel.translatesAutoresizingMaskIntoConstraints = false
        lifesLabel.text = "LIFES: \(lifes)"
        lifesLabel.textAlignment = .right
        view.addSubview(lifesLabel)
        
        clueLabel = UILabel()
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.text = "CLUE"
        clueLabel.font = UIFont.systemFont(ofSize: 44)
        clueLabel.textAlignment = .center
        clueLabel.numberOfLines = 0
        clueLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(clueLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.text = "ANSWER"
        answerLabel.numberOfLines = 1
        answerLabel.font = UIFont.systemFont(ofSize: 70)
        answerLabel.textAlignment = .center
        view.addSubview(answerLabel)
        
        let nextButton = UIButton(type: .system)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("NEXT", for: .normal)
        //nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 44)
        view.addSubview(nextButton)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 2
        buttonsView.layer.cornerRadius = 10
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "SCORE: 0"
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            lifesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            lifesLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            clueLabel.topAnchor.constraint(equalTo: lifesLabel.bottomAnchor, constant: 20),
            clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clueLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            answerLabel.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 20),
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            nextButton.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 15),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 44),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 20),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.widthAnchor.constraint(equalToConstant: 730),
            buttonsView.heightAnchor.constraint(equalToConstant: 420),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            
            scoreLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            
        ])
        
        //clueLabel.backgroundColor = .lightGray
        //answerLabel.backgroundColor = .yellow
        //buttonsView.backgroundColor = .gray
        
        let width = 150
        let height = 70
        
        for row in (0..<6){
            for column in (0..<5){
                let letterButton = UIButton(type: .system)
                letterButton.setTitle("W", for: .normal)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
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
        loadLevel()
        loadLetter()
    }
    
    func loadLevel(){
       // let defaults = UserDefaults.standard
        
        if let levelUrl = Bundle.main.url(forResource: "level", withExtension: "txt"){
            if let levelContents = try? String(contentsOf: levelUrl){
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                for line in lines{
                    let parts = line.components(separatedBy: ": ")
                    var answer = parts[0]
                    let clue = parts[1]
                    
                    clues.append(clue)
                    answer = answer.replacingOccurrences(of: "|", with: "")
                    answers.append(answer)
                }
                
            }
            loadGame()
        }
        print(clues)
        print(answers)
        
    }
    
    func loadGame(level: Int = 0){
        let index = level
        var answerString = ""
        currentAnswer = answers[index]
        if let currentAnswer = currentAnswer {
            for _ in currentAnswer{
                answerString += "?"
            }
        }
        
        clueLabel.text = clues[index]
        answerLabel.text = answerString
    }
    
    func loadLetter(){
        
        if let lettersURL = Bundle.main.url(forResource: "letters", withExtension: "txt"){
            if let lettersContent = try? String(contentsOf: lettersURL){
                let letters = lettersContent.components(separatedBy: "\n")
                if letters.count == letterButtons.count{
                    for (index,button) in letterButtons.enumerated() {
                        button.setTitle(letters[index].uppercased(), for: .normal)
                        if letters[index] == "."{
                            button.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    @objc func letterTapped(_ sender: UIButton){
        guard let letter = sender.titleLabel?.text else{ return }
        guard let currentAnswer = currentAnswer else { return }
        
            if currentAnswer.contains(letter){
                var positions = [Int]()
                for (index, char) in currentAnswer.enumerated(){
                    if char == Character(letter){
                        positions.append(index)
                    }
                }
                guard var answerString = answerLabel.text else { return }
                var answerChar = [Character]()
                for str in answerString{
                    answerChar.append(str)
                }
                for position in positions {
                    answerChar[position] = Character(letter)
                }
                
                answerString = ""
                for char in answerChar{
                    answerString += String(char)
                }
                answerLabel.text = answerString
                activatedButtons.append(sender)
                sender.isHidden = true
                
                if answerString == currentAnswer{
                    let ac = UIAlertController(title: "Well done", message: "Go to next question?", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nextQuestion))
                    present(ac, animated: true)
                }
            } else{
                if lifes == 0{
                    let vc = UIAlertController(title: "You've died", message: "Your score is \(score)", preferredStyle: .alert)
                    vc.addAction(UIAlertAction(title: "Ok", style: .default, handler: newGame))
                    present(vc, animated: true)
                } else {
                    let ac  = UIAlertController(title: "Wrong letter", message: "Try again", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default){
                        [weak self] action in
                        self?.lifes -= 1
                    })
                    present(ac, animated: true)
                
                }
                
            }
    }
    
    func newGame(aciton: UIAlertAction){
        
    }
    
    func nextQuestion(action: UIAlertAction){
        
        score += 1
        guard let currentPosition = answers.firstIndex(of: currentAnswer!) else { return }
        let newPosition = currentPosition + 1
        if newPosition < answers.count{
            loadGame(level: newPosition)
            for button in activatedButtons {
                button.isHidden = false
            }
            activatedButtons.removeAll()
        } else{
            let ac = UIAlertController(title: "Congratulations", message: "You've answered all questions, your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: newGame))
            present(ac, animated: true)
        }
        
    }
}




//
//  ViewController.swift
//  project8over
//
//  Created by Ainura Kerimkulova on 26/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var letterButtons = [UIButton]()
   
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    var solutions = [String]()
    var activatedButtons = [UIButton]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.text = "CLUES"
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.text = "ANSWERS"
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.isUserInteractionEnabled = false
        currentAnswer.textAlignment = .center
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.cornerRadius = 10
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: -100),
            
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor ),
            
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonsView.widthAnchor.constraint(equalToConstant: 650),
            buttonsView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        let width = 130
        let height = 60
        
        for row in (0..<4){
            for column in (0..<5){
                let letterButton = UIButton(type: .system)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
        loadLevel()
    }

    func loadLevel(){
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        var lines = [String]()
       /* let defaults = UserDefaults.standard
        var levelNum = defaults.string(forKey: "level\(level)")*/
        
        if let levelFileUrl = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let levelContents = try? String(contentsOf: levelFileUrl){
                lines = levelContents.components(separatedBy: "\n")
            }
        } else{
            let defaults = UserDefaults.standard
            if let levelsArray = defaults.object(forKey: "levels") as? [String]{
                let levelContents = levelsArray[level - 1]
                lines = levelContents.components(separatedBy: "\n")
            }
        }
        
        if lines.count == 8{
            lines.remove(at: 7)
        }
        
        lines.shuffle()
        
        for (index, line) in lines.enumerated(){
            let parts = line.components(separatedBy: ": ")
            let answer = parts[0]
            let clue = parts[1]
            
            clueString += "\(index + 1). \(clue)\n"
            let solutionWord = answer.replacingOccurrences(of: "|", with: "")
            solutionString += "\(solutionWord.count) letters\n"
            solutions.append(solutionWord)
            
            let bits = answer.components(separatedBy: "|")
            letterBits += bits
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits.shuffle()
        if letterBits.count == letterButtons.count{
            for i in (0..<letterButtons.count) {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    @objc func submitTapped(_ sender: UIButton! = nil){
        guard let answerText = currentAnswer.text else { return }
        if let solutionPosition = solutions.firstIndex(of: answerText){
            activatedButtons.removeAll()
            solutions[solutionPosition] = ""
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            var solutionsFound = true
            for solution in solutions {
                if solution != ""{
                    solutionsFound = false
                }
            }
            if solutionsFound{
                var title = "Well done!"
                var message = "Wanna load next level?"
                
                let defaults = UserDefaults.standard
                var scores = defaults.object(forKey: "scores") as? [Int] ?? [Int]()
                var ScoreIsHighest = true
                for scoreItem in scores{
                    if score < scoreItem{
                        ScoreIsHighest = false
                    }
                }
                
                if ScoreIsHighest{
                    title = "Congratulations"
                    message = "You bit your last highest score"
                }
                var notLastLevel = true
                if let levels = defaults.object(forKey: "levels") as? [String]{
                    if levels.count == level{
                        title = "Congratulations!!!"
                        message = "You've finished all levels"
                        notLastLevel = false
                    }
                    
                }
                
                scores.append(score)
                defaults.set(scores, forKey: "scores")
                
                let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                if notLastLevel{
                    ac.addAction(UIAlertAction(title: "Next level", style: .default, handler: levelUp))
                }
                ac.addAction(UIAlertAction(title: "Finish the game", style: .default){
                    [weak self] action in
                    let vc = InitialViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                    
                })
                present(ac, animated: true)
            }
        }else if sender != nil{
 
            let vc = UIAlertController(title: "Wrong answer", message: "Try again", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Ok", style: .default){
                [weak self] action in
                for btn in self!.activatedButtons{
                    btn.isHidden = false
                }
                self?.activatedButtons.removeAll()
                self?.currentAnswer.text = ""
                self?.score -= 1
            })
            present(vc, animated: true)
            
            /*for btn in activatedButtons{
                btn.isHidden = false
            }
            activatedButtons.removeAll()
            currentAnswer.text = ""*/
        }
    }
    
    @objc func clearTapped(_ sender: UIButton){
        currentAnswer.text = ""
        for btn in activatedButtons{
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
        
    }
    
    @objc func letterTapped(_ sender: UIButton){
        guard let buttonTitle = sender.titleLabel?.text else{ return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
        
        submitTapped()
        
    }
    
    func levelUp(action: UIAlertAction){
        level += 1
        loadLevel()
        
        for btn in letterButtons{
            btn.isHidden = false
        }
    }

}


//
//  AddLevelViewController.swift
//  project8over
//
//  Created by Ainura Kerimkulova on 26/3/22.
//

import UIKit

class AddLevelViewController: UIViewController {
    
    var titleLabel: UILabel!
    var cluesFields = [UITextField]()
    var answersFields = [UITextField]()
    var numsLabels = [UILabel]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "Enter clues in textfields on the left and answers on the right"
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(titleLabel)
        
        for i in (0..<7){
            let numLabel = UILabel()
            numLabel.translatesAutoresizingMaskIntoConstraints = false
            numLabel.textAlignment = .left
            numLabel.font = UIFont.systemFont(ofSize: 24)
            numLabel.text = "\(i + 1)."
            numsLabels.append(numLabel)
            view.addSubview(numLabel)
            
            let clueTextField = UITextField()
            clueTextField.translatesAutoresizingMaskIntoConstraints = false
            clueTextField.placeholder = "Enter clue for your solution"
            clueTextField.textAlignment = .center
            clueTextField.font = UIFont.systemFont(ofSize: 24)
            clueTextField.layer.borderWidth = 1
            clueTextField.layer.borderColor = UIColor.lightGray.cgColor
            clueTextField.layer.cornerRadius = 6
            cluesFields.append(clueTextField)
            view.addSubview(clueTextField)
            
            let answerTextField = UITextField()
            answerTextField.translatesAutoresizingMaskIntoConstraints = false
            answerTextField.placeholder = "Enter answer"
            answerTextField.textAlignment = .center
            answerTextField.font = UIFont.systemFont(ofSize: 24)
            answerTextField.layer.borderWidth = 1
            answerTextField.layer.borderColor = UIColor.lightGray.cgColor
            answerTextField.layer.cornerRadius = 6
            answersFields.append(answerTextField)
            view.addSubview(answerTextField)
        }
        
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submitButton)
 
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        for i in (0..<7){
            if i == 0{
                NSLayoutConstraint.activate([
                    numsLabels[i].topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
                    
                    cluesFields[i].topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                    
                    answersFields[i].topAnchor.constraint(equalTo: cluesFields[i].topAnchor),
                ])
            } else {
                NSLayoutConstraint.activate([
                    numsLabels[i].topAnchor.constraint(equalTo: numsLabels[i - 1].bottomAnchor, constant: 20),
                    
                    cluesFields[i].topAnchor.constraint(equalTo: cluesFields[i - 1].bottomAnchor, constant: 20),
                    answersFields[i].topAnchor.constraint(equalTo: answersFields[i - 1].bottomAnchor, constant: 20)
                ])
            }
            NSLayoutConstraint.activate([
                numsLabels[i].widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
                numsLabels[i].leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
                numsLabels[i].heightAnchor.constraint(equalToConstant: 45),
                
                cluesFields[i].widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: -100),
                cluesFields[i].leadingAnchor.constraint(equalTo: numsLabels[i].layoutMarginsGuide.leadingAnchor, constant: 20),
                cluesFields[i].heightAnchor.constraint(equalToConstant: 45),
                
                answersFields[i].widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: -100),
                answersFields[i].trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
                answersFields[i].heightAnchor.constraint(equalToConstant: 45)
                
            ])
            
            NSLayoutConstraint.activate([
                submitButton.topAnchor.constraint(equalTo: answersFields[answersFields.count - 1].bottomAnchor, constant: 20),
                submitButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -120)
            ])
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @objc func submitTapped(){
        var isComplete = true
        for i in (0..<7){
            if (cluesFields[i].text == "" || answersFields[i].text == ""){
                isComplete = false
                break
            }
        }
        
        if isComplete{
            var levelString = ""
            var clues = [String]()
            var answers = [String]()
            var countLetters = 0
            for i in (0..<7){
                guard let clue = cluesFields[i].text else { return }
                guard let answer = answersFields[i].text else { return }
                clues.append(clue)
                answers.append(answer)
                
                countLetters += answer.count
            }
            if countLetters >= 20{
                var shortestWord = answers[0]
                for answer in answers {
                    if answer.count < shortestWord.count{
                        shortestWord = answer
                    }
                }
                for i in (0..<7) {
                    if answers[i] == shortestWord{
                        if answers[i].count % 2 == 0{
                            let position = answers[i].count / 2
                            var answerChar = [Character]()
                            for letter in answers[i]{
                                answerChar += letter.uppercased()
                            }
                            answerChar.insert("|", at: position)
                            for char in answerChar {
                                levelString += "\(char)"
                            }
                            levelString += ": \(clues[i].lowercased().capitalized)\n"
                            
                        }else{
 
                            var answerChar = [Character]()
                            for letter in answers[i]{
                                answerChar += letter.uppercased()
                            }
                            answerChar.insert("|", at: 4)
                            for char in answerChar {
                                levelString += "\(char)"
                            }
                            levelString += ": \(clues[i].lowercased().capitalized)\n"
                        }
                        
                    }else if answers[i].count % 3 == 0{
                        let position = answers[i].count / 3
                        var answerChar = [Character]()
                        for letter in answers[i]{
                            answerChar += letter.uppercased()
                        }
                        answerChar.insert("|", at: position)
                        answerChar.insert("|", at: position * 2 + 1)
                        for char in answerChar {
                            levelString += "\(char)"
                        }
                        levelString += ": \(clues[i].lowercased().capitalized)\n"
                            
                    }else if answers[i].count > 9 {
                        
                        var answerChar = [Character]()
                        for letter in answers[i]{
                            answerChar += letter.uppercased()
                        }
                        answerChar.insert("|", at: 4)
                        answerChar.insert("|", at: 9)
                        for char in answerChar {
                            levelString += "\(char)"
                        }
                        levelString += ": \(clues[i].lowercased().capitalized)\n"
                        
                    } else if answers[i].count < 5{
                        var answerChar = [Character]()
                        for letter in answers[i]{
                            answerChar += letter.uppercased()
                        }
                        answerChar.insert("|", at: 1)
                        answerChar.insert("|", at: 3)
                        for char in answerChar {
                            levelString += "\(char)"
                        }
                        levelString += ": \(clues[i].lowercased().capitalized)\n"
                    } else{
                        var answerChar = [Character]()
                        for letter in answers[i]{
                            answerChar += letter.uppercased()
                        }
                        answerChar.insert("|", at: 2)
                        answerChar.insert("|", at: 5)
                        for char in answerChar {
                            levelString += "\(char)"
                        }
                        levelString += ": \(clues[i].lowercased().capitalized)\n"
                    }
                }
                print(levelString)
                
                let defaults = UserDefaults.standard
                var levels = defaults.object(forKey: "levels") as? [String] ?? [String]()
                levels.append(levelString)
                defaults.set(levels, forKey: "levels")
                
                let vc = InitialViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let ac = UIAlertController(title: "Your answers are too short", message: "Please complete all clues and answers", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                present(ac, animated: true)
            }
        }else{
            let ac = UIAlertController(title: "You didn't fill all text fields", message: "Please complete all clues and answers", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
    
}

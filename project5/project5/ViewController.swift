//
//  ViewController.swift
//  project5
//
//  Created by Ainura Kerimkulova on 16/2/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startNewGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty == true{
            allWords = ["silkworm"]
        }
        
        let defaults = UserDefaults.standard
        
        guard (defaults.object(forKey: "allWords") as? [String]) != nil else{
            defaults.set(allWords, forKey: "allWords")
            return
        }
        
        
        startGame()
    }
    
    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData() // calls number of rows and cell fo row at
        let defaults = UserDefaults.standard
        guard (defaults.object(forKey: title!) as? [String]) != nil else{
            defaults.set([title], forKey: title!)
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    @objc func startNewGame(){
        startGame()
    }
    
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        
      //  let errorTitle: String
      //  let errorMessage: String
        
        if isReal(word: lowerAnswer){
            if isNotShort(word: lowerAnswer){
                if isOriginal(word: lowerAnswer){
                    if isNotTitle(word: lowerAnswer){
                        if isPossible(word: lowerAnswer){
                            
                            usedWords.insert(lowerAnswer, at: 0)
                        
                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)
                            
                            let defaults = UserDefaults.standard
                            if var savedWords = defaults.object(forKey: title!) as? [String]{
                                savedWords += [lowerAnswer]
                                defaults.set(savedWords, forKey: title!)
                            }
                            
                            return
                        
                            } else{
                               // errorTitle = "Word is not possible"
                                //errorMessage = "You can't spell the word from \(title!)"
                                showErrorMessage(title: "Word is not possible", message: "You can't spell the word from \(title!)")
                        }
                    
                    }else {
                        showErrorMessage(title: "You used title word", message: "Try to use other words")
                        
                    }
                } else{
                    //errorTitle = "You already used the word"
                   // errorMessage = "Be more creative"
                    showErrorMessage(title: "You already used the word", message: "Be more creative")

                }
            }else{
                //errorTitle = "Word is too short"
               // errorMessage = "Use longer words"
                showErrorMessage(title: "Word is too short", message: "Use longer words"
)
            }
        
        }else{
          //  errorTitle = "Word not recognized"
           // errorMessage = "You can't just make up new words"
            showErrorMessage(title: "Word not recognized", message: "You can't just make up new words")
        }
        
            
    }
    
    func isPossible(word: String) -> Bool{
        guard var tempWord = title?.lowercased() else {return false}
        
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            } else{
                return false
            }
        }
        return true    }
    
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if misspelledRange.location == NSNotFound{
            return true
        }
        else{
            return false
        }
    }
    
    func isNotShort(word: String) -> Bool{
        return word.count >= 3
    }
    
    func isNotTitle(word: String) -> Bool{
        return word != title
    }
    
    func showErrorMessage(title: String, message: String){
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Ok", style: .default))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem

    present(ac, animated: true)

    }

}


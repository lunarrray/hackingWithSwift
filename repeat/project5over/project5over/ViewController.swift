//
//  ViewController.swift
//  project5over
//
//  Created by Ainura Kerimkulova on 23/3/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(newGame))
        
        
        let UsedTitleWords = UIBarButtonItem(title: "Show words", style: .plain, target: self, action: #selector(goToList))
        
        toolbarItems = [UsedTitleWords]
        navigationController?.isToolbarHidden = false
        
        if let StartWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: StartWordsURL){
                allWords = startWords.components(separatedBy: "\n")
                
                let defaults = UserDefaults.standard
                defaults.set(allWords, forKey: "allWords")
            }
        }
        
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        
       startGame()
        
    }
    
    @objc func newGame(){
        startGame()
    }
    
    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer(){
        let vc = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        vc.addTextField()
        let submitAction = UIAlertAction(title: "Confirm", style: .default){
            [weak self, weak vc] action in
            if let answer = vc?.textFields?[0].text{
                self?.submit(answer)
            }else{
                return
            }
        }
        vc.addAction(submitAction)
        present(vc, animated: true)
    }

    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        var title = ""
        
        if isntShort(lowerAnswer){
            if isOriginal(lowerAnswer){
                if isReal(lowerAnswer){
                    if isntTitle(lowerAnswer){
                        if isPossible(lowerAnswer){
                            usedWords.insert(lowerAnswer, at: 0)
                            
                            let defaults = UserDefaults.standard
                            var savedWords = defaults.object(forKey: self.title!) as? [String] ?? [String]()
                            savedWords.append(lowerAnswer)
                            let setOfWords = Set(savedWords)
                            savedWords = Array(setOfWords)
                            defaults.set(savedWords, forKey: self.title!)
                            
                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)
                        }else{
                            title = "The word wasn't constructed from title word"
                        }
                        
                    }else{
                        title = "You can't use title word"
                    }
                    
                }else{
                    title = "The word doesn't exist"
                }
            }else{
                title = "You've already used the word"
            }
            
        }else{
            title = "The word is too short"
        }
        
        if title != ""{
            let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
        
        
        
    }
    
    func isReal(_ word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspeledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspeledRange.location == NSNotFound
    }
    
    func isPossible(_ word:String) -> Bool{
        var tempWord = title?.lowercased()
        for letter in word{
            if let position = tempWord?.firstIndex(of: letter){
                tempWord?.remove(at: position)
            }else{
                return false
            }
        }
        return true
    }
    
    func isOriginal(_ word: String) -> Bool{
        return !usedWords.contains(word)
    }
    
    func isntTitle(_ word: String) -> Bool{
        if word != title{
            return true
        }else{
            return false
        }
    }
    
    func isntShort(_ word: String) -> Bool{
        if word.count > 2{
            return true
        }else{
            return false
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word")!
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func goToList(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "List") as? ListViewController else{return}
        navigationController?.pushViewController(vc, animated: true)
    }

    

}


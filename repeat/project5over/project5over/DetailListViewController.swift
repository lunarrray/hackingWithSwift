//
//  DetailListViewController.swift
//  project5over
//
//  Created by Ainura Kerimkulova on 23/3/22.
//

import UIKit

class DetailListViewController: UITableViewController {
    
    var titleWord: String?
    var words = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let titleWord = titleWord {
            title = titleWord
            let defaults = UserDefaults.standard
            if let savedWords = defaults.object(forKey: title!) as? [String]{
                words = savedWords
        }

    }
}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = words[indexPath.row]
        return cell
    }
}


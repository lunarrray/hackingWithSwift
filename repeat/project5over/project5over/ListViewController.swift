//
//  ListViewController.swift
//  project5over
//
//  Created by Ainura Kerimkulova on 23/3/22.
//

import UIKit

class ListViewController: UITableViewController {
    
    var listOfTitles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let savedTitles = defaults.object(forKey: "allWords") as? [String] ?? [String]()
        for savedTitle in savedTitles {
            
            let savedWords = defaults.object(forKey: savedTitle) as? [String] ?? [String]()
            if !savedWords.isEmpty{
                listOfTitles.append(savedTitle)
            }
            
        }
        // = ["silkworm"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleWord")!
        cell.textLabel?.text = listOfTitles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let ac = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailListViewController else{ return }
        ac.titleWord = listOfTitles[indexPath.row]
        navigationController?.pushViewController(ac, animated: true)
    }



}

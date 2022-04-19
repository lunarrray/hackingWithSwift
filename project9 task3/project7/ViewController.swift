//
//  ViewController.swift
//  project7
//
//  Created by Ainura Kerimkulova on 24/2/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
   // var petitions = ["aaa", "bbb", "ccc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Source", style: .plain, target: self, action: #selector(showSource))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchByWord))
        
        
        let urlString:String
        
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    @objc func showSource(){
        let vc = UIAlertController(title: "The data comes from", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .default))
        present(vc, animated: true)
    }
    
    @objc func searchByWord(){
        let vc = UIAlertController(title: "You are looking for:", message: nil, preferredStyle: .alert)
        vc.addTextField()
        
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak vc] action in
                guard let keyWord = vc?.textFields?[0].text else{return}
                DispatchQueue.global().async {
                    [weak self]  in
                        self?.submit(keyWord: keyWord)
            }
            
        }
        
        vc.addAction(submitAction)
        present(vc, animated: true)
    }
    
    
    func submit(keyWord: String){
        let lowerKeyWord = keyWord.lowercased()
        for petition in petitions{
            if petition.title.lowercased().contains(lowerKeyWord){
                filteredPetitions.append(petition)
            }
        }
        if filteredPetitions.isEmpty{
            DispatchQueue.main.async {
                [weak self] in
                let ac = UIAlertController(title: "Can not find anything including:", message: "\(keyWord)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                self?.present(ac, animated: true)
            }
            
            return
        }
        petitions = filteredPetitions
        DispatchQueue.main.async {
            [weak self] in
            self?.tableView.reloadData()
        }
       
        
    }
    
    func showError(){
        let ac = UIAlertController(title: "Loading error", message: "Check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    

}


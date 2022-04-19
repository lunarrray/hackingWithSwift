//
//  ViewController.swift
//  project7over
//
//  Created by Ainura Kerimkulova on 25/3/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Petitions"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        
        getData()
    }
    
    func getData(){
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
    
        }
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
            }else{
                showError()
            }
        }else{
            showError()
        }
    }
    
    func parse(json: Data){
        let jsonDecoder = JSONDecoder()
        
        if let jsonPetitions = try? jsonDecoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            tableView.reloadData()
        }else{
            showError()
        }
    }
        
    @objc func showCredits(){
            let vc = UIAlertController(title: "Data source: ", message: "From the We The People API of the Whitehouse.", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "OK", style: .default))
            present(vc, animated: true)
        }
    
    @objc func search(){
        getData()
        let ac = UIAlertController(title: "You are looking for: ", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let searchAction = UIAlertAction(title: "Search", style: .default){
            [weak self, weak ac] action in
            guard let keyword = ac?.textFields?[0].text else{ return }
            if keyword == ""{
                return
            }
            var filteredPetitions = [Petition]()
            for petition in self!.petitions {
                if petition.title.lowercased().contains(keyword){
                        filteredPetitions.append(petition)
                    }
            }
            
            if filteredPetitions.isEmpty{
                let ac = UIAlertController(title: "Failed to find", message: "Couldn't find petitions containing '\(keyword)' ", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                self?.present(ac, animated: true)
            }else{
                self?.petitions = filteredPetitions
                self?.tableView.reloadData()
            }
        }
        ac.addAction(searchAction)
        present(ac, animated: true)
    }
    
    func showError(){
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}


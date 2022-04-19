//
//  ViewController.swift
//  day32over
//
//  Created by Ainura Kerimkulova on 24/3/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var categories = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
        
        let defaults = UserDefaults.standard
        if let savedCategories = defaults.object(forKey: "categories") as? [String]{
            categories = savedCategories
        }
        
    }
    
    @objc func addCategory(){
        let ac = UIAlertController(title: "Add new category", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addCategoryAction = UIAlertAction(title: "Add", style: .default){
            [weak self, weak ac] action in
            guard let newCategory = ac?.textFields?[0].text else{ return }
            if newCategory == "" {
                return
            }
            self?.add(newCategory)
        }
        ac.addAction(addCategoryAction)
        present(ac, animated: true)
    }
    
    func add(_ category: String){
        var errorTitle = ""
        let categLower = category.lowercased()
        if isOriginal(categLower){
            categories.insert(categLower, at: 0)
            
            let defaults = UserDefaults.standard
            var savedCategories = defaults.object(forKey: "categories") as? [String] ?? [String]()
            savedCategories.insert(categLower, at: 0)
            defaults.set(savedCategories, forKey: "categories")

            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }else{
            errorTitle = "You already have the category"
        }
        
        if errorTitle != "" {
            let vc = UIAlertController(title: errorTitle, message: nil, preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Ok", style: .default))
            present(vc, animated: true)
        }
        
    }
    
    func isOriginal(_ category: String) -> Bool{
        if categories.contains(category){
            return false
        }
        return true
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailTableViewController else{ return}
        vc.category = categories[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}


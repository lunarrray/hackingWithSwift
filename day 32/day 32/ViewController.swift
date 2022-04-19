//
//  ViewController.swift
//  day 32
//
//  Created by Ainura Kerimkulova on 21/2/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    var selectedIndexPaths = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping list"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cleanList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if self.selectedIndexPaths.contains(indexPath){
                cell.accessoryType = .none
                self.selectedIndexPaths.remove(at: indexPath.row)
            } else{
                cell.accessoryType = .checkmark
                self.selectedIndexPaths.insert(indexPath, at: indexPath.row)
            }
        }
    }
    
  
    
    @objc func cleanList(){
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func addNewItem(){
        let ac = UIAlertController(title: "Adding new item", message: "Enter product to buy", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] action in
            guard let newItem = ac?.textFields?[0].text else{return}
            self?.submit(newItem)
        }
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    func submit( _ newItem: String){
        shoppingList.insert(newItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        //return
    }


}


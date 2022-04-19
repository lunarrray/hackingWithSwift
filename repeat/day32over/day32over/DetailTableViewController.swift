//
//  DetailTableViewController.swift
//  day32over
//
//  Created by Ainura Kerimkulova on 24/3/22.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var category: String?
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        
        title = category!
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteItems))
        
        toolbarItems = [spacer, delete]
        navigationController?.isToolbarHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        let defaults = UserDefaults.standard
        if let savedItems = defaults.object(forKey: title!) as? [String]{
            items = savedItems
        }
        
    }
    
    
    @objc func addItem(){
        let ac = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addItemAction = UIAlertAction(title: "Add", style: .default){
            [weak self, weak ac] action in
            guard let newItem = ac?.textFields?[0].text else{ return }
            if newItem == "" {
                return
            }
            self?.add(newItem)
        }
        ac.addAction(addItemAction)
        present(ac, animated: true)
    }
    
    func add(_ item: String){
        var errorTitle = ""
        let itemlower = item.lowercased()
        if isOriginal(itemlower){
            items.insert(itemlower, at: 0)
            
            let defaults = UserDefaults.standard
            var savedItems = defaults.object(forKey: title!) as? [String] ?? [String]()
            savedItems.insert(itemlower, at: 0)
            defaults.set(savedItems, forKey: title!)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }else{
            errorTitle = "You already have the item"
        }
        
        if errorTitle != "" {
            let vc = UIAlertController(title: errorTitle, message: nil, preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Ok", style: .default))
            present(vc, animated: true)
        }
        
    }
    
    func isOriginal(_ item: String) -> Bool{
        if items.contains(item){
            return false
        }
        return true
    }
    

    @objc func deleteItems() {
        items.removeAll(keepingCapacity: true)
        let defaults = UserDefaults.standard
        defaults.set(items, forKey: title!)
        tableView.reloadData()
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.capitalized
        
        let defaults = UserDefaults.standard
        let checked = defaults.bool(forKey: item + "Checked")
        if checked{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        let checkmark = UITableViewCell.AccessoryType.checkmark
        
        let defaults = UserDefaults.standard
        
        if cell?.accessoryType == checkmark{
            cell?.accessoryType = .none
            defaults.set(false, forKey: item + "Checked")
        }else{
            cell?.accessoryType = checkmark
            defaults.set(true, forKey: item + "Checked")
        }

    }
    
    


}

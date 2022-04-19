//
//  ViewController.swift
//  day23
//
//  Created by Ainura Kerimkulova on 7/2/22.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var countries = [String]()
    let cellSpacingHeight: CGFloat = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries and flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        countries += ["estonia", "france",  "germany", "ireland", "italy", "monaco", "nigeria", "russia", "poland", "spain", "uk", "us"]
            }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        cell.textLabel?.text = countries[indexPath.row].capitalized
        
        
        cell.layer.borderWidth = 4
        cell.layer.borderColor = UIColor.white.cgColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
        vc.selectedImage = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        }
    }
  
}


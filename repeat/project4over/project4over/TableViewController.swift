//
//  TableViewController.swift
//  project4over
//
//  Created by Ainura Kerimkulova on 22/3/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    let websites = ["hackingwithswift.com", "apple.com/swift/", "waitbutwhy.com", "theoatmeal.com"]


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? ViewController else{
            print("Failed to load the website")
            return
        }
        
        vc.currentWebsite = websites[indexPath.row]
        vc.websites = websites
        
        navigationController?.pushViewController(vc, animated: true)
    }


}

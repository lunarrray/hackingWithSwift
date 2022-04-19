//
//  ViewController.swift
//  project4
//
//  Created by Ainura Kerimkulova on 15/2/22.
//

import UIKit
import WebKit

class ViewController: UITableViewController, WKNavigationDelegate {
    var websites = ["waitbutwhy.com", "hackingwithswift.com", "apple.com", "omegle.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sites you can visit"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Site", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.websites = websites
            vc.currentWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

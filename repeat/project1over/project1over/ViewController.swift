//
//  ViewController.swift
//  project1over
//
//  Created by Ainura Kerimkulova on 20/3/22.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
                pictures.sort()
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        cell.textLabel?.text = picture
        let defaults = UserDefaults.standard
        
        let openedTimes = defaults.integer(forKey: picture)
        
        switch openedTimes{
        case 0:
            cell.detailTextLabel?.text = "Never have been opened"
        case 1:
            cell.detailTextLabel?.text = "Opened 1 time"
        default:
            cell.detailTextLabel?.text = "Opened \(openedTimes) times"
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            let picture = pictures[indexPath.row]
            vc.selectedImage = picture
            vc.countImages = pictures.count
            vc.numOfImage = indexPath.row + 1
            
            let defaults = UserDefaults.standard
            let openedTimes = defaults.integer(forKey: picture)
            defaults.set(openedTimes + 1, forKey: picture)
            navigationController?.pushViewController(vc, animated: true)
            tableView.reloadData()
        }
    }

}


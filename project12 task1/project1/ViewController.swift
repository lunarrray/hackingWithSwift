//
//  ViewController.swift
//  project1
//
//  Created by Ainura Kerimkulova on 22/1/22.
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
        
        for item in items{
            if item.hasPrefix("nssl"){
                pictures.append(item)
                pictures.sort()
            }

        }
        
        
       // print(pictures)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        
        let defaults = UserDefaults.standard
        if let shownTimes = defaults.object(forKey: pictures[indexPath.row]) as? Int{
            cell.detailTextLabel?.text = "It was shown \(shownTimes) times"
        }
        
        return cell
  
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.numOfPictures = pictures.count
            vc.imageNum = indexPath.row + 1
            let defaults = UserDefaults.standard
            if let countShows = defaults.object(forKey: pictures[indexPath.row]) as? Int{
                defaults.set(countShows + 1, forKey: pictures[indexPath.row])
            }else{
                defaults.set(1, forKey: pictures[indexPath.row])
            }
            
            navigationController?.pushViewController(vc, animated: true)
            tableView.reloadData()
        }
    }
    



}


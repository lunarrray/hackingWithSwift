//
//  ViewController.swift
//  project1
//
//  Created by Ainura Kerimkulova on 22/1/22.
//

import UIKit

class ViewController: UICollectionViewController {
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else{
            fatalError("Unable to dequeue PictureCell")
        }
        
        let image = pictures[indexPath.row]
        cell.imageView.image = UIImage(named: image)
        
       /* cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 1
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 20*/
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.numOfPictures = pictures.count
            vc.imageNum = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}


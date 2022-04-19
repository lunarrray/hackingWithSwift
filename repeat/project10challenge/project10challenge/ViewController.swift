//
//  ViewController.swift
//  project10challenge
//
//  Created by Ainura Kerimkulova on 31/3/22.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.contains("nssl"){
                pictures.append(item)
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else{
            fatalError("Failed to load PictureCell")
        }
        let picture = pictures[indexPath.item]
        cell.name.text = picture
        cell.imageView.image = UIImage(named: picture)
        cell.imageView.layer.borderWidth = 1
        cell.imageView.layer.borderColor = UIColor(white: 0.2, alpha: 1).cgColor
        cell.imageView.layer.cornerRadius = 5
        cell.layer.cornerRadius = 7
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else{
            return
        }
        vc.selectedImage = pictures[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }


}


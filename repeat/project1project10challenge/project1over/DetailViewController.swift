//
//  DetailViewController.swift
//  project1over
//
//  Created by Ainura Kerimkulova on 20/3/22.
//

import UIKit

class DetailViewController: UICollectionViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var numOfImage: Int?
    var countImages: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never
        if let loadImage = selectedImage{
            imageView.image = UIImage(named: loadImage)
            title = "\(numOfImage!) of \(countImages!)"
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else{
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

}

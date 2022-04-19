//
//  DetailViewController.swift
//  day23
//
//  Created by Ainura Kerimkulova on 7/2/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage?.capitalized
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ShareTapped))
        
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
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
    
    @objc func ShareTapped(){
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else{
            print("No image not found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage!.capitalized], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    
    }
    

 

}

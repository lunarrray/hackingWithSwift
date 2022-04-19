//
//  DetailViewController.swift
//  day50
//
//  Created by Ainura Kerimkulova on 19/3/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var path: URL?
    var caption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = caption
        
        if let path = path {
            imageView.image = UIImage(contentsOfFile: path.path)
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

}

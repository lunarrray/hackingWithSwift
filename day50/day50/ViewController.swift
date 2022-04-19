//
//  ViewController.swift
//  day50
//
//  Created by Ainura Kerimkulova on 19/3/22.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPicture))
        
       
        
        let defaults = UserDefaults.standard
        if let savedPicture = defaults.object(forKey: "pictures") as? Data{
            let JSONDecoder = JSONDecoder()
            
            do{
                pictures = try JSONDecoder.decode([Picture].self, from: savedPicture)
            }catch{
                print("Failed to load pictures")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        cell.textLabel?.text = picture.caption
        return cell
    }
    
    @objc func addNewPicture(){
        let picker = UIImagePickerController()
        //picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        
        let picture = Picture(imageName: imageName, caption: "No caption")
        
        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Add caption for image", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Set caption", style: .default){
            [weak self, weak ac] action in
            guard var caption = ac?.textFields?[0].text else {return}
            if caption == ""{
                caption = "No caption"
            }
            picture.caption = caption
            self?.tableView.reloadData()
        })
        present(ac, animated: true)
        
        pictures.append(picture)
        save()
        

    }
    
    func getDocumentsDirectory() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            
            let picture = pictures[indexPath.row]
            
            let path = getDocumentsDirectory().appendingPathComponent(picture.imageName)
            vc.path = path
            vc.caption = picture.caption
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save(){
        let JSONEncoder = JSONEncoder()
        
        if let savedData = try? JSONEncoder.encode(pictures){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "pictures")
        }else{
            print("Failed to save picture")
        }
        
    }


}


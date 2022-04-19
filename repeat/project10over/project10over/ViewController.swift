//
//  ViewController.swift
//  project10over
//
//  Created by Ainura Kerimkulova on 30/3/22.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPerson))
        
        let jsonDecoder = JSONDecoder()
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data{
            do{
                people = try jsonDecoder.decode([Person].self, from: savedPeople)
            }catch{
                print("Failed to load people")
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else{
            fatalError("Unable to dequeque PersonCell")
        }
        let person = people[indexPath.item]
        cell.name.text = person.name
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0.3, alpha: 1).cgColor
        cell.imageView.layer.cornerRadius = 5
        cell.imageView.layer.borderWidth = 2
        cell.layer.cornerRadius = 9
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let vc = UIAlertController(title: "Do you want to delete or rename the person?", message: nil, preferredStyle: .alert)
        let renameAction = UIAlertAction(title: "Rename", style: .default){
            [weak self] action in
            let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
            ac.addTextField()
            let rename = UIAlertAction(title: "Rename", style: .default){
                [weak self, weak ac] action in
                guard let newName = ac?.textFields?[0].text else { return }
                if newName != ""{
                    person.name = newName.lowercased().capitalized
                }else{
                    return
                }
                self?.save()
                self?.collectionView.reloadData()
            }
            ac.addAction(rename)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(ac, animated: true)
        }
        vc.addAction(renameAction)
        let deleteAction = UIAlertAction(title: "Delete", style: .default){
            [weak self] action in
            self?.people.remove(at: indexPath.item)
            collectionView.reloadData()
            self?.save()
        }
        vc.addAction(deleteAction)
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(vc, animated: true)
    }
    
    @objc func addPerson(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        save()
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        let jsonEncoder = JSONEncoder()
        if let jsonPeople = try? jsonEncoder.encode(people){
            let defaults = UserDefaults.standard
            defaults.set(jsonPeople, forKey: "people")
        }else{
            print("Failed to save people")
        }
        
    }


}


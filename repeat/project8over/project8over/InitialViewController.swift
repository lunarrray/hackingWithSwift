//
//  InitialViewController.swift
//  project8over
//
//  Created by Ainura Kerimkulova on 26/3/22.
//

import UIKit

class InitialViewController: UIViewController {
    var welcomeLabel: UILabel!
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = .white
        
        welcomeLabel = UILabel()
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "Swifty Words"
        welcomeLabel.font = UIFont.systemFont(ofSize: 50)
        view.addSubview(welcomeLabel)
        
        let playButton = UIButton(type: .system)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("PLAY", for: .normal)
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 44)
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        view.addSubview(playButton)
        
        let chooseLevelButton = UIButton(type: .system)
        chooseLevelButton.translatesAutoresizingMaskIntoConstraints = false
        chooseLevelButton.setTitle("Chose Level", for: .normal)
        chooseLevelButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        chooseLevelButton.addTarget(self, action: #selector(choseLevel), for: .touchUpInside)
        view.addSubview(chooseLevelButton)
        
        let addLevelButton = UIButton(type: .system)
        addLevelButton.translatesAutoresizingMaskIntoConstraints = false
        addLevelButton.setTitle("Add New Level", for: .normal)
        addLevelButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        addLevelButton.addTarget(self, action: #selector(addLevel), for: .touchUpInside)
        view.addSubview(addLevelButton)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            chooseLevelButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            chooseLevelButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            
            addLevelButton.topAnchor.constraint(equalTo: chooseLevelButton.topAnchor),
            addLevelButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        /*let defaults = UserDefaults.standard

        var levels = defaults.object(forKey: "levels") as? [String] ?? [String]()
        levels.removeAll()
        defaults.set(levels, forKey: "levels")
        if levels.isEmpty{
            for i in (1...2){
                if let levelsUrl = Bundle.main.url(forResource: "level\(i)", withExtension: "txt"){
                    if let levelContents = try? String(contentsOf: levelsUrl){
                            levels.append(levelContents)
                    }
                }
            }
        }
        defaults.set(levels, forKey: "levels")
        levels.remove(at: 2)
        levels.remove(at: 2)
        defaults.set(levels, forKey: "levels")
        print(levels)*/
    }
    
    @objc func play(){
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func choseLevel(){
        let ac = UIAlertController(title: "Choose Level To Play", message: nil, preferredStyle: .alert)
        let defaults = UserDefaults.standard
        let levels = defaults.object(forKey: "levels") as? [String] ?? [String]()
        for i in (0..<levels.count) {
            ac.addAction(UIAlertAction(title: "\(i + 1)", style: .default){
                [weak self] action in
                let vc = ViewController()
                vc.level = Int(action.title!) ?? 1
                self?.navigationController?.pushViewController(vc, animated: true)
            })
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func addLevel(){
        let vc = AddLevelViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

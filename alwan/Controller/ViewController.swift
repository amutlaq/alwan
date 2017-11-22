//
//  ViewController.swift
//  alwan
//
//  Created by Anhar on 11/15/17.
//  Copyright © 2017 Anhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let startGametButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Game", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    @objc func startGame() {
        let gameData = GameData()
        let vc = ColorViewController()
        vc.gameData = gameData
        present(vc, animated: true, completion: nil)
    }
    
    private let highscoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font =  UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }

    func setupView() {
        
        self.view.addSubview(startGametButton)
        self.view.addSubview(highscoreLabel)
        
        //need x, y, width, height constraints
        startGametButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startGametButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        startGametButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        startGametButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //need x, y, width, height constraints
        highscoreLabel.topAnchor.constraint(equalTo: startGametButton.bottomAnchor, constant: 8).isActive = true
        highscoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        highscoreLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        highscoreLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        highscoreLabel.text = "Highscore: " +  String(UserDefaults.standard.integer(forKey: "Highscore"))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}


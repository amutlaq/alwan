//
//  ColorViewController.swift
//  alwan
//
//  Created by Anhar on 11/15/17.
//  Copyright © 2017 Anhar. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    var gameData: GameData!
    var index = 0
    var timer = Timer()
    var gameOver = false
    var switchColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (gameOver == true) {
            dismiss(animated: false, completion: nil)
            return
        }
        
        self.gameData.addRandomColor()
       
        displayNextColor()
    }
    
    @objc func displayNextColor() {
        timer.invalidate()
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = self.switchColor
            self.view.backgroundColor = self.gameData.colorMapDictionary[self.gameData.sequenceArray[self.index]]
        })
        index += 1
        if index < gameData.sequenceArray.count {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(displayNextColor), userInfo: nil, repeats: false)

        } else { 
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(returnToButtons), userInfo: nil, repeats: false)
        }
    }
    
    @objc func returnToButtons() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let buttonsViewController = ButtonsViewController(collectionViewLayout: layout)
        buttonsViewController.gameData = gameData
        present(buttonsViewController, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        index = 0
        view.backgroundColor = gameData.colorMapDictionary[gameData.sequenceArray[index]]
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

//
//  ButtonsViewController.swift
//  alwan
//
//  Created by Anhar on 11/15/17.
//  Copyright © 2017 Anhar. All rights reserved.
//

import UIKit
import AVFoundation

class ButtonsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var correctSound: AVAudioPlayer?
    var wrongSound: AVAudioPlayer?
    
    var gameData: GameData!
    var index = 0
    var highscore = UserDefaults.standard.integer(forKey: "Highscore")
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(ButtonCell.self, forCellWithReuseIdentifier: cellId)
        createAudioPlayers()

    }
    
    func createAudioPlayers() {
        if let correctSound = createAudioPlayerForFile(file: "correct", ofType: "aiff") {
            self.correctSound = correctSound
            correctSound.prepareToPlay()
        }
        if let wrongSound = createAudioPlayerForFile(file: "wrong", ofType: "aiff") {
            self.wrongSound = wrongSound
            wrongSound.prepareToPlay()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        index = 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width)/2
        let height: CGFloat = (UIScreen.main.bounds.height)/2
        
        return CGSize(width: width, height: height)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ButtonCell

        buttonCell.color = gameData.colors[indexPath.item]
        buttonCell.backgroundColor = gameData.colorMapDictionary[buttonCell.color!]
        buttonCell.alpha = 0.7
        
        return buttonCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedColor = gameData.colors[indexPath.item]
        
        if selectedColor == gameData.sequenceArray[index] {
            correctSound?.play()
            
            index += 1
            
            if index >= gameData.sequenceArray.count {
                dismiss(animated: true, completion: nil)
            }

        } else {
            wrongSound?.play()
            
            if (gameData.sequenceArray.count - 1) > highscore {
              UserDefaults.standard.set((gameData.sequenceArray.count - 1), forKey: "Highscore")
            }

            showAlert()
        }
    }

    func showAlert() {

        let alertController = UIAlertController(title: "Game Over", message: "Score: \(gameData.sequenceArray.count - 1)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Try again", style: .default) { (action: UIAlertAction) -> Void in
                if let vc = self.presentingViewController as? ColorViewController {
                    vc.gameOver = true
                    self.dismiss(animated: false, completion: nil)
                }
            }
            alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
  
    }
    
    func createAudioPlayerForFile(file: String, ofType type: String) -> AVAudioPlayer? {
        let path = Bundle.main.path(forResource: file, ofType: type)
        let url = NSURL.fileURL(withPath: path!)
        
        var audioPlayer: AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print("Error initializing player")
        }
        
        return audioPlayer
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}




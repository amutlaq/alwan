//
//  GameData.swift
//  alwan
//
//  Created by Anhar on 11/15/17.
//  Copyright © 2017 Anhar. All rights reserved.
//

import UIKit

class GameData {
    
    let colors = ["Red","Green","Blue","Yellow"]
    
    let colorMapDictionary = [
        "Red": UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0),
        "Blue": UIColor(red: 34.0/255.0, green: 167.0/255.0, blue: 240.0/255.0, alpha: 1.0),
        "Green": UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0),
        "Yellow": UIColor(red: 248.0/255.0, green: 148.0/255.0, blue: 6.0/255.0, alpha: 1.0)]

    var sequenceArray = [String]()

    func addRandomColor(){
        let randomColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        let randomColorString = colors[randomColorIndex]

        sequenceArray.append(randomColorString)
    }
    
    func resetSequence() {
        sequenceArray.removeAll()
    }
    
}

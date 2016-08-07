//
//  SoundAssist.swift
//  babyselfie
//
//  Created by Alexander Kaump on 8/6/16.
//  Copyright © 2016 Alexander Kaump. All rights reserved.
//

import AVFoundation

class SoundAssist {
    
    class func randomSoundEffect() -> NSURL? {
        
        let dictArray = SoundAssist.dictReturn()
        let selectedArray = SoundAssist.returnSelect()
        var checkArray = [[String: String]]()
        
        for dict in dictArray {
            if selectedArray.contains(dict["name"]!) {
                checkArray.append(dict)
            }
            
        }
        
        if checkArray.count == 0 {
            return nil 
        }

        let random = Int(arc4random_uniform(UInt32(checkArray.count)))
        let dict = checkArray[random]
        
        let buttonAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(dict["name"], ofType: dict["ext"])!)
        
        print(dict)
        
        return buttonAudioURL
    }
    
    class func dictReturn() -> [[String: String]] {
        var dictArray = [[String: String]]()
        dictArray.append(["name":"cow", "ext": "mp3"])
        dictArray.append(["name":"Rooster", "ext": "mp3"])
        dictArray.append(["name":"Jump7", "ext": "wav"])
        dictArray.append(["name":"explode", "ext": "wav"])
        dictArray.append(["name":"Jump9", "ext": "wav"])
        dictArray.append(["name":"pig", "ext": "mp3"])
        dictArray.append(["name":"bleat", "ext": "mp3"])
        dictArray.append(["name":"neigh", "ext": "mp3"])
        dictArray.append(["name":"boop", "ext": "mp3"])
        dictArray.append(["name":"spring", "ext": "mp3"])

        return dictArray
    }
    
    class func addSelect(name: String) {
        var selectedArray = SoundAssist.returnSelect()
        selectedArray.append(name)
        NSUserDefaults.standardUserDefaults().setValue(selectedArray, forKey: "selectedSounds")
    }
    
    class func removeSelect(name: String) {
        var selectedArray = SoundAssist.returnSelect()
        selectedArray.removeAtIndex(selectedArray.indexOf(name)!)
        NSUserDefaults.standardUserDefaults().setValue(selectedArray, forKey: "selectedSounds")
    }
    
    class func returnSelect() -> [String] {
    
        var selectedArray = [String]()
        if let fetchedArray = NSUserDefaults.standardUserDefaults().valueForKey("selectedSounds") as? [String] {
            selectedArray.appendContentsOf(fetchedArray)
        }
        
        return selectedArray
    }
}

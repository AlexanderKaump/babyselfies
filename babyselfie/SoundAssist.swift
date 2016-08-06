//
//  SoundAssist.swift
//  babyselfie
//
//  Created by Alexander Kaump on 8/6/16.
//  Copyright © 2016 Alexander Kaump. All rights reserved.
//

import AVFoundation

class SoundAssist {
    
    class func randomSoundEffect() -> NSURL {
        
        var dictArray = [[String: String]]()
        //dictArray.append(["name":"explode", "ext": "wav"])
        dictArray.append(["name":"cow", "ext": "mp3"])
        dictArray.append(["name":"Rooster", "ext": "mp3"])
        dictArray.append(["name":"Jump7", "ext": "wav"])
        dictArray.append(["name":"Randomize5", "ext": "wav"])
        dictArray.append(["name":"explode", "ext": "wav"])
        

        let random = Int(arc4random_uniform(UInt32(dictArray.count)))
        let dict = dictArray[random]
        
        let buttonAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(dict["name"], ofType: dict["ext"])!)
        
        print(dict)
        
        return buttonAudioURL
    }
    
}

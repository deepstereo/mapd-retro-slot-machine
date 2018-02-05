//
//  Sounds.swift
//  retro-slot
//
//  Created by Sergey Kozak on 05/02/2018.
//  Copyright © 2018 Centennial. All rights reserved.
//

import UIKit
import AVFoundation

struct Sounds {
    
    var winSound = Bundle.main.url(forResource: "asteroid", withExtension: "mp3")
    
    func playWinSound() {
        do {
            let myplayer = try AVAudioPlayer(contentsOf: winSound!)
            myplayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }

}

//
//  SoundManager.swift
//  MatchGame
//
//  Created by Gregor Kramer on 17.02.2021.
//

import Foundation
import AVFoundation


class SoundManager {
    
    var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case match
        case nomatch
        case shuffle
    }
    
    func playSound(effect: SoundEffect) {
        
        var soundFileName = ""
        
        switch effect {
        case .flip:
            soundFileName = "cardflip"
        case .match:
            soundFileName = "dingcorrect"
        case .nomatch:
            soundFileName = "dingwrong"
        case .shuffle:
            soundFileName = "shuffle"
        }
        
        
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
        
        guard bundlePath != nil else {return}
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        
        audioPlayer?.play()
        
    }
    
}

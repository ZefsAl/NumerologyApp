//
//  MusicManager.swift
//  Numerology
//
//  Created by Serj_M1Pro on 25.08.2024.
//

import AVFoundation
import SwiftUI



struct SoundsName {
    static let melody1 = "Starry sky"
    static let melody2 = "Silent night"
    static let melody3 = "Starry harmony"
}

class MusicManager: ObservableObject {
    
    static let shared = MusicManager()
    
    @Published var isOnMusic: Bool = UserDefaults.standard.bool(forKey: UserDefaultsKeys.bgMusicState)
    @Published var selectedMelody: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.selectedMelody) ?? SoundsName.melody1 {
        didSet {
            myPrint("selectedMelody", selectedMelody)
            setupAndPlaySound()
        }
    }
    
    var player: AVAudioPlayer?
    
    func setupAndPlaySound() {
        
        guard let url = Bundle.main.url(forResource: selectedMelody, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.soloAmbient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.numberOfLoops = -1
            
        } catch let error {
            myPrint(error.localizedDescription)
        }
        //
        guard
            let state = UserDefaults.standard.object(forKey: UserDefaultsKeys.bgMusicState) as? Bool
        else {
            UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.bgMusicState)
            self.playSound()
            return
        }
        
        state ? playSound() : stopSound()
    }

    func playSound() {
        let state = UserDefaults.standard.object(forKey: UserDefaultsKeys.bgMusicState) as? Bool
        if
            let state = state,
            state
        {
            self.player?.play()
        }
    }
    
    func stopSound() {
        self.player?.stop()
    }
    
    
}


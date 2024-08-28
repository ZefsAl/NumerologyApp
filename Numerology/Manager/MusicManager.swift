//
//  MusicManager.swift
//  Numerology
//
//  Created by Serj_M1Pro on 25.08.2024.
//

import AVFoundation


// Нужен User Defaults для сохранения состояния включенного/выключенного звука

class MusicManager {
    
    static let shared = MusicManager()
    
    var player: AVAudioPlayer?
    
//    func checkSoundState() -> Bool {
//        let state = UserDefaults.standard.object(forKey: UserDefaultsKeys.bgMusicState) as? Bool
//        return state ?? false
//    }
    
    func setupAndPlaySound() {
        
        guard let url = Bundle.main.url(forResource: "NumerologyAudio", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.soloAmbient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.numberOfLoops = -1
            
        } catch let error {
            print(error.localizedDescription)
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

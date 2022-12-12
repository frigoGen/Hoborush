//
//  AudioClass.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 12/12/22.
//

import Foundation
import SpriteKit
import AVFoundation

/**Manages a shared instance of JKAudioPlayer.*/
private let JKAudioInstance = JKAudioPlayer()

/**Provides an easy way to play sounds and music. Use sharedInstance method to access a single object for the entire game to manage the sound and music.*/
public class JKAudioPlayer {

    /**Used to access music.*/
    var musicPlayer: AVAudioPlayer!

    /** Allows the audio to be shared with other music (such as music being played from your music app). If this setting is false, music you play from your music player will stop when this app's music starts. Default set by Apple is false. */
    static var canShareAudio = false {
        didSet {
            canShareAudio ? try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient) : try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
        }
    }

    /**Creates an instance of the JAAudio class so the user doesn't have to make their own instance and allows use of the functions. */
    public class func sharedInstance() -> JKAudioPlayer {
        return JKAudioInstance
    }

/**Plays music. You can ignore the "type" property if you include the full name with extension in the "filename" property. Set "canShareAudio" to true if you want other music to be able to play at the same time (default by Apple is false).*/
    public func playMusic(fileName: String, withExtension type: String = "") {
        if let url = Bundle.main.url(forResource: fileName, withExtension: type) {
            musicPlayer = try? AVAudioPlayer(contentsOf: url)
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        }
    }

    /**Stops the music. Use the "resumeMusic" method to turn it back on. */
    public func stopMusic() {
        if musicPlayer != nil && musicPlayer!.isPlaying {
            musicPlayer.currentTime = 0
            musicPlayer.stop()
        }
    }

    /**Pauses the music. Use the "resumeMusic" method to turn it back on. */
    public func pauseMusic() {
        if musicPlayer != nil && musicPlayer!.isPlaying {
            musicPlayer.pause()
        }
    }

    /**Resumes the music after being stopped or paused. */
    public func resumeMusic() {
        if musicPlayer != nil && !musicPlayer!.isPlaying {
            musicPlayer.play()
        }
    }

    /**Plays a sound only once. Must be used inside a runAction(...) method.*/
    public func playSound(fileName: String) -> SKAction? {
        return SKAction.playSoundFileNamed(fileName, waitForCompletion: false)
    }
}

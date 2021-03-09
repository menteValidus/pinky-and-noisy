//
//  PinkyAndNoisyApp.swift
//  PinkyAndNoisy
//
//  Created by Denis Cherniy on 16.01.2021.
//

import SwiftUI
import AVFoundation
import MediaPlayer

@main
struct PinkyAndNoisyApp: App {
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }

    var body: some Scene {
        WindowGroup {
            GeneratorScreen()
        }
    }
}

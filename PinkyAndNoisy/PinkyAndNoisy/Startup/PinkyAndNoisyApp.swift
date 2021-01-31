//
//  PinkyAndNoisyApp.swift
//  PinkyAndNoisy
//
//  Created by Denis Cherniy on 16.01.2021.
//

import SwiftUI
import AVFoundation

@main
struct PinkyAndNoisyApp: App {
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
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

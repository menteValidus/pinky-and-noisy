//
//  NoiseGenerator.swift
//  PinkyAndNoisy
//
//  Created by Denis Cherniy on 16.01.2021.
//

import AudioKit
import AVKit

final class NoiseGenerator {
    private let manager: AudioEngine
    private let pinkNoise: PinkNoise

    private var audioPlayer: AVAudioPlayer?

    init(amplitude: Float) {
        manager = .init()
        pinkNoise = PinkNoise(amplitude: amplitude)

        manager.output = pinkNoise
        try? manager.start()
    }

    func start() {
        pinkNoise.start()
    }

    func stop() {
        pinkNoise.stop()
    }
}

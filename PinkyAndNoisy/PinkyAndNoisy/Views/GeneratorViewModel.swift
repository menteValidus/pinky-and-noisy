//
//  GeneratorViewModel.swift
//  PinkyAndNoisy
//
//  Created by Denis Cherniy on 16.01.2021.
//

import Foundation
import AVFoundation
import MediaPlayer

final class GeneratorViewModel: ObservableObject {
    let soundGenerator: NoiseGenerator = .init(amplitude: 0.5)
    private var nowPlayingInfo: [String: Any] = [:]

    @Published var generatorStarted: Bool = false

    init() {
        setupMediaPlayerNotificationView()
    }

    private func setupMediaPlayerNotificationView() {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.playCommand.addTarget { [weak self] _ in
            print("play")
            self?.start()
            return .success
        }

        commandCenter.pauseCommand.addTarget { [weak self] _ in
            print("pause")
            self?.stop()
            return .success
        }
    }

    func start() {
        soundGenerator.start()
        generatorStarted = true
        setupNotificationView()
    }

    func stop() {
        soundGenerator.stop()
        generatorStarted = false
    }

    func setupNotificationView() {
        nowPlayingInfo = [:]
        nowPlayingInfo[MPMediaItemPropertyTitle] = "Pink noise"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "Pinky&Noisy"

        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}

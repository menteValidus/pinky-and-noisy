//
//  GeneratorViewModel.swift
//  PinkyAndNoisy
//
//  Created by Denis Cherniy on 16.01.2021.
//

import Foundation
import AVFoundation

final class GeneratorViewModel: ObservableObject {
    let soundGenerator: NoiseGenerator = .init(amplitude: 0.5)

    @Published var generatorStarted: Bool = false

    func start() {
        soundGenerator.start()
        generatorStarted = true
    }

    func stop() {
        soundGenerator.stop()
        generatorStarted = false
    }
}

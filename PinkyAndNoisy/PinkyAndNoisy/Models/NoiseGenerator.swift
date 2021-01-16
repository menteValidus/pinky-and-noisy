//
//  NoiseGenerator.swift
//  PinkyAndNoisy
//
//  Created by Denis Cherniy on 16.01.2021.
//

import AVFoundation

final class NoiseGenerator {
    let twoPi = 2 * Float.pi
    let frequency: Float = 440

    let engine = AVAudioEngine()

    var mainMixer: AVAudioMixerNode {
        engine.mainMixerNode
    }

    var output: AVAudioOutputNode {
        engine.outputNode
    }

    var outputFormat: AVAudioFormat {
        output.inputFormat(forBus: 0)
    }

    var sampleRate: Float {
        Float(outputFormat.sampleRate)
    }

    var inputFormat: AVAudioFormat? {
        AVAudioFormat(commonFormat: outputFormat.commonFormat,
                      sampleRate: outputFormat.sampleRate,
                      channels: 1,
                      interleaved: outputFormat.isInterleaved)
    }

    var phaseIncrement: Float {
        (twoPi / sampleRate) * frequency
    }
    var currentPhase: Float = 0

    init(amplitude: Float) {
        let sourceNode = AVAudioSourceNode { [unowned self] _, _, frameCount, audioBufferList in
            let audioBufferListPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            for frame in 0..<Int(frameCount) {
                let value = whiteNoiseSignal() * amplitude
                currentPhase += phaseIncrement

                switch currentPhase {
                case twoPi...:
                    currentPhase -= twoPi
                case ...0:
                    currentPhase += twoPi
                default:
                    break
                }

                for buffer in audioBufferListPointer {
                    let buf: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    buf[frame] = value
                }
            }
            return noErr
        }

        engine.attach(sourceNode)

        engine.connect(sourceNode, to: mainMixer, format: inputFormat)
        engine.connect(mainMixer, to: output, format: outputFormat)

        mainMixer.outputVolume = 0.5
    }

    private func whiteNoiseSignal() -> Float {
        return (Float(arc4random_uniform(UINT32_MAX)) / Float(UINT32_MAX)) * 2 - 1 // White noise
    }

    func start() {
        try? engine.start()
    }

    func stop() {
        engine.stop()
    }
}

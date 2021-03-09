//
//  PlayerScreen.swift
//  PinkyAndNoisy
//
//  Created by Denis Cherniy on 16.01.2021.
//

import SwiftUI

struct PlayerScreen: View {
    @ObservedObject var viewModel = PlayerScreenViewModel()

    var body: some View {
        Button(viewModel.generatorStarted ? "Stop" : "Start") {
            if viewModel.generatorStarted {
                viewModel.stop()
            } else {
                viewModel.start()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerScreen()
    }
}

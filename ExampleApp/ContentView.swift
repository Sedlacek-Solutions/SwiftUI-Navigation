//
//  ContentView.swift
//  SwiftUI-Navigation
//
//  Created by James Sedlacek on 5/7/25.
//

import Navigation
import SwiftUI

@MainActor
public struct ContentView: View {
    @DestinationState private var destinations: [TestDestination] = []

    public init() {}

    public var body: some View {
        Navigator(path: $destinations) {
            VStack {
                Button("Push Screen", action: pushScreenAction)
            }
        }
    }

    @MainActor
    private func pushScreenAction() {
        destinations.navigate(to: .example("Hello World!"))
    }
}

#Preview {
    ContentView()
}

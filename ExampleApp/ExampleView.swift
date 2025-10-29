import Navigation
import SwiftUI

public struct ExampleView: View {
    @DestinationState private var destinations: [TestDestination] = []
    @State private var sheetDestination: SheetDestination? = nil
    private let title: String

    @MainActor
    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        VStack(spacing: 40) {
            Button("Push Screen", action: pushScreenAction)

            Text(title)

            Button("Present Sheet", action: presentSheetAction)
        }
        .sheet(item: $sheetDestination)
    }

    @MainActor
    private func pushScreenAction() {
        destinations.navigate(to: .lastExample)
    }

    private func presentSheetAction() {
        sheetDestination = .sheetExample("It's a whole new world!")
    }
}

public struct SheetExampleView: View {
    @State private var destination: AnotherDestination? = nil
    private let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        if #available(iOS 17.0, macOS 14.0, *) {
            VStack(spacing: 40) {
                Button("Push Screen", action: pushScreenAction)
                
                Text(title)
            }
            .navigationDestination(item: $destination)
        }
    }

    private func pushScreenAction() {
        destination = .anotherExample("Testing")
    }
}

public struct AnotherExampleView: View {
    private let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        Text(title)
    }
}

public struct LastExampleView: View {
    @DestinationState private var destinations: [TestDestination] = []

    @MainActor
    public init() {}

    public var body: some View {
        Button("Navigate to Root", action: navigateToRootAction)
    }

    @MainActor
    private func navigateToRootAction() {
        destinations.navigateToRoot()
    }
}

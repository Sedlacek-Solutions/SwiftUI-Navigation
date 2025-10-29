//
//  TestDestination.swift
//  SwiftUI-Navigation
//
//  Created by James Sedlacek on 5/7/25.
//

import Navigation
import SwiftUI

public enum TestDestination: Destination {
    case example(String)
    case lastExample

    public var body: some View {
        switch self {
        case .example(let title):
            ExampleView(title: title)
        case .lastExample:
            LastExampleView()
        }
    }
}

public enum SheetDestination: Destination {
    case sheetExample(String)

    public var body: some View {
        switch self {
        case .sheetExample(let title):
            SheetExampleView(title: title)
        }
    }
}

extension SheetDestination: Identifiable {
    public nonisolated var id: Self { self }
}

public enum AnotherDestination: Destination {
    case anotherExample(String)

    public var body: some View {
        switch self {
        case .anotherExample(let title):
            AnotherExampleView(title: title)
        }
    }
}

//
//  Destination.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

/// A convenience type-alias used throughout the routing system.
///
/// It bundles the three capabilities a “destination” typically needs:
///   • `View`     – supplies the screen’s UI
///   • `Hashable` – lets the destination live inside navigation paths/sets
///   • `Codable`  – enables persistence & deep-link restoration
///
/// Usage:
/// ```swift
///public enum TestDestination: Destination {
///    case example(String)
///    case lastExample
///
///    public var body: some View {
///        switch self {
///        case .example(let title):
///            ExampleView(title: title)
///        case .lastExample:
///            LastExampleView()
///        }
///    }
///}
/// ```
public typealias Destination = View & Hashable & Codable

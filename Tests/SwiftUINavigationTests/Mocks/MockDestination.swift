//
//  MockDestination.swift
//
//
//  Created by James Sedlacek on 2/10/24.
//

import Navigation
import SwiftUI

enum MockDestination: Destination {
    case settings
    case profile

    var body: some View {
        switch self {
        case .settings:
            MockSettingsView()
        case .profile:
            MockProfileView()
        }
    }
}

struct MockSettingsView: View {
    var body: some View {
        Text("Mock Settings View")
    }
}

struct MockProfileView: View {
    var body: some View {
        Text("Mock Profile View")
    }
}

//
//  ArraySwiftUINavigationTests.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import Testing
@testable import Navigation

@MainActor
struct ArraySwiftUINavigationTests {
    @Test("Navigate to a single destination")
    func navigateToSingleDestination() {
        var stack: [MockDestination] = []
        stack.navigate(to: .settings)
        #expect(stack.count == 1)
        #expect(stack.last == .settings)
    }

    @Test("Navigate to multiple destinations")
    func navigateToMultipleDestinations() {
        var stack: [MockDestination] = []
        stack.navigate(to: [.settings, .profile, .settings])
        #expect(stack.count == 3)
        #expect(stack == [.settings, .profile, .settings])
    }

    @Test("Navigate back one step")
    func navigateBackOneStep() {
        var stack: [MockDestination] = [.settings, .profile]
        stack.navigateBack()
        #expect(stack.count == 1)
        #expect(stack == [.settings])
    }

    @Test("Navigate back zero steps")
    func navigateBackZeroSteps() {
        var stack: [MockDestination] = [.settings, .profile]
        stack.navigateBack(0)
        #expect(stack.count == 2)
        #expect(stack == [.settings, .profile])
    }

    @Test("Navigate back negative steps")
    func navigateBackNegativeSteps() {
        var stack: [MockDestination] = [.settings, .profile]
        stack.navigateBack(-1)
        #expect(stack.count == 2)
        #expect(stack == [.settings, .profile])
    }

    @Test("Navigate back multiple steps")
    func navigateBackMultipleSteps() {
        var stack: [MockDestination] = [.settings, .profile, .settings, .profile]
        stack.navigateBack(2)
        #expect(stack.count == 2)
        #expect(stack == [.settings, .profile])
    }

    @Test("Navigate back too many steps")
    func navigateBackTooManySteps() {
        var stack: [MockDestination] = [.settings, .profile]
        stack.navigateBack(3)
        #expect(stack.isEmpty)
    }

    @Test("Navigate to root")
    func navigateToRoot() {
        var stack: [MockDestination] = [.settings, .profile, .settings]
        stack.navigateToRoot()
        #expect(stack.isEmpty)
    }

    @Test("Navigate back to a specific destination")
    func navigateBackToSpecificDestination() {
        var stack: [MockDestination] = [.settings, .profile, .settings, .profile, .settings]
        stack.navigateBack(to: .profile) // Navigates back to the last occurrence of .profile
        #expect(stack.count == 4)
        #expect(stack == [.settings, .profile, .settings, .profile])
    }

    @Test("Navigate back to a non-existent destination in the stack")
    func navigateBackToNonExistentDestination() {
        var stack: [MockDestination] = [.settings, .settings, .settings]
        // .profile is not in the stack, so it should do nothing.
        stack.navigateBack(to: .profile)
        #expect(stack.count == 3)
        #expect(stack == [.settings, .settings, .settings])
    }

    @Test("Navigate back to a specific destination that is currently on top")
    func navigateBackToDestinationOnTop() {
        var stack: [MockDestination] = [.settings, .profile]
        stack.navigateBack(to: .profile)
        #expect(stack.count == 2)
        #expect(stack == [.settings, .profile])
    }

    @Test("Navigate back to the first occurrence of a destination")
    func navigateBackToFirstOccurrence() {
        var stack: [MockDestination] = [.profile, .settings, .profile, .settings]
        stack.navigateBack(to: .profile) // Should go to the second .profile
        #expect(stack == [.profile, .settings, .profile])
    }

    @Test("Replace stack with empty destinations")
    func replaceWithEmptyDestinations() {
        var stack: [MockDestination] = [.settings, .profile, .settings]
        stack.replace(with: [])
        #expect(stack.isEmpty)
    }

    @Test("Replace stack with new destinations")
    func replaceWithNewDestinations() {
        var stack: [MockDestination] = [.settings, .settings]
        stack.replace(with: [.profile, .settings, .profile])
        #expect(stack.count == 3)
        #expect(stack == [.profile, .settings, .profile])
    }
}

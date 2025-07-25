import Foundation
@testable import OnboardingApp

final class MockEventLogger: EventLogging {
    private(set) var loggedEvents: [(event: String, parameters: [String: Any]?)] = []

    func sendEvent(_ event: String) {
        loggedEvents.append((event: event, parameters: nil))
    }

    func sendEvent(_ event: String, parameters: [String : Any]) {
        loggedEvents.append((event: event, parameters: parameters))
    }
}

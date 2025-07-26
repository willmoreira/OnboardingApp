import Foundation
@testable import OnboardingApp

final class MockDocumentCaptureRouter: DocumentCaptureRouterProtocol {
    var navigateCalled = false

    func navigateToNextStep() {
        navigateCalled = true
    }
}

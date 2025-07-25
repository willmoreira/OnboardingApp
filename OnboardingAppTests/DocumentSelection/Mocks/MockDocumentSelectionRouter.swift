@testable import OnboardingApp

final class MockDocumentSelectionRouter: DocumentSelectionRouterProtocol {
    var navigated = false
    func navigateToDocumentCapture() {
        navigated = true
    }
}

@testable import OnboardingApp

final class DocumentSelectionRouterMock: DocumentSelectionRouterProtocol {

    private(set) var navigated = false

    func navigateToDocumentCapture() {
        navigated = true
    }
}

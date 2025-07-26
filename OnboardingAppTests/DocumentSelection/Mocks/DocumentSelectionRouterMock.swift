@testable import OnboardingApp

final class DocumentSelectionRouterMock: DocumentSelectionRouterProtocol {

    var navigated = false
    func navigateToDocumentCapture() {
        navigated = true
    }
}

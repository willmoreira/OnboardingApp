import Foundation
@testable import OnboardingApp

final class DocumentCaptureRouterMock: DocumentCaptureRouterProtocol {
    var navigateCalled = false

    func navigateToNextStep() {
        navigateCalled = true
    }
}

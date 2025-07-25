import Foundation
@testable import OnboardingApp
import CoreKit

final class MockDocumentCaptureRouter: DocumentCaptureRouterProtocol {
    var navigateCalled = false

    func navigateToNextStep() {
        navigateCalled = true
    }
}

import Foundation
@testable import OnboardingApp

final class DocumentCaptureRouterMock: DocumentCaptureRouterProtocol {

    private(set) var restartFlowCalled = false

    func restartFlow() {
        restartFlowCalled = true
    }
}

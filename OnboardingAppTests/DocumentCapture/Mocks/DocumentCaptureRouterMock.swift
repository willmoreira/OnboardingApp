import Foundation
@testable import OnboardingApp

final class DocumentCaptureRouterMock: DocumentCaptureRouterProtocol {

    var restartFlowCalled = false

    func restartFlow() {
        restartFlowCalled = true
    }
}

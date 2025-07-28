import Foundation
@testable import OnboardingApp

final class BirthDateRouterMock: BirthDateRouterProtocol {
    private(set) var routeToDocumentCaptureCalled = false

    func routeToDocumentCapture() {
        routeToDocumentCaptureCalled = true
    }
}

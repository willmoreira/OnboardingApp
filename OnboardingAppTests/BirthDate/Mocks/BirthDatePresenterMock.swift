import Foundation
@testable import OnboardingApp

final class BirthDatePresenterMock: BirthDateInteractorOutputProtocol {

    private(set) var receivedResponse: BirthDateEntity.Response?
    private(set) var presentValidationCalled = false

    func presentValidation(_ response: BirthDateEntity.Response) {
        presentValidationCalled = true
        receivedResponse = response
    }
}

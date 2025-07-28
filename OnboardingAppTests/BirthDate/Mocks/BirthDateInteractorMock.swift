import Foundation
@testable import OnboardingApp

final class BirthDateInteractorMock: BirthDateInteractorProtocol {

    private(set) var validateRequest: BirthDateEntity.Request?
    private(set) var validateCalled = false
    private(set) var saveBirthDateCalled = false

    func validateBirthDate(_ request: BirthDateEntity.Request) {
        validateCalled = true
        validateRequest = request
    }

    func saveBirthDate() {
        saveBirthDateCalled = true
    }
}

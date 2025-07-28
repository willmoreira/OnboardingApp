import Foundation
@testable import OnboardingApp

final class BirthDateViewMock: BirthDateViewProtocol {
    
    private(set) var receivedViewModel: BirthDateEntity.ViewModel?
    private(set) var displayValidationCalled = false

    func displayValidation(_ viewModel: BirthDateEntity.ViewModel) {
        displayValidationCalled = true
        receivedViewModel = viewModel
    }
}

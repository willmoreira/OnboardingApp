import Foundation

final class BirthDatePresenterUITestMock: BirthDatePresenterProtocol {
    var view: BirthDateViewProtocol?

    var validateBirthDateCalled = false
    var goToDocumentCaptureCalled = false

    func validateBirthDate(_ request: BirthDateEntity.Request) {
        validateBirthDateCalled = true

        let eighteenYearsAgo = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        let isValid = request.entity.date <= eighteenYearsAgo
        let viewModel = BirthDateEntity.ViewModel(isValid: isValid)
        view?.displayValidation(viewModel)
    }

    func goToDocumentCapture() {
        goToDocumentCaptureCalled = true
    }
}

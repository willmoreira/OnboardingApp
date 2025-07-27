import UIKit
@testable import OnboardingApp

final class DocumentCaptureViewMock: DocumentCaptureViewProtocol {

    private(set) var showErrorMessageCalled = false
    private(set) var showSuccessMessageCalled = false
    private(set) var showLoadingCalled = false
    private(set) var hideLoadingCalled = false
    private(set) var showCapturedImageCalled = false
    private(set) var displayedCountryName: String?
    private(set) var displayedDocumentName: String?
    private(set) var displayBirthDateFormattedCalled = false

    func showErrorMessage() {
        showErrorMessageCalled = true
    }

    func showSuccessMessage() {
        showSuccessMessageCalled = true
    }

    func showLoading(_ show: Bool) {
        if show {
            showLoadingCalled = true
        } else {
            hideLoadingCalled = true
        }
    }

    func showCapturedImage(_ image: UIImage) {
        showCapturedImageCalled = true
    }

    func displayUserSelection(_ viewModel: UserSelectionEntity.ViewModel) {
        displayedCountryName = viewModel.countryName
        displayedDocumentName = viewModel.documentName
        displayBirthDateFormattedCalled = true
    }
}

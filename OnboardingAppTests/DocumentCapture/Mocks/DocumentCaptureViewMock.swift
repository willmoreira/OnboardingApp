import UIKit
@testable import OnboardingApp

final class DocumentCaptureViewMock: DocumentCaptureViewProtocol {

    var showErrorMessageCalled = false
    var showSuccessMessageCalled = false
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var capturedImage: UIImage?
    var displayedCountryName: String?
    var displayedDocumentName: String?

    func showErrorMessage() {
        showErrorMessageCalled = true
    }

    func showSuccessMessage() {
        showSuccessMessageCalled = true
    }

    func showLoading(_ isLoading: Bool) {
        if isLoading {
            showLoadingCalled = true
        } else {
            hideLoadingCalled = true
        }
    }

    func showCapturedImage(_ image: UIImage) {
        capturedImage = image
    }

    func displaySelectedCountry(_ countryName: String) {
        displayedCountryName = countryName
    }

    func displaySelectedDocument(_ documentName: String) {
        displayedDocumentName = documentName
    }
}

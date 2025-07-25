import UIKit
@testable import OnboardingApp

final class DocumentCaptureInteractorMock: DocumentCaptureInteractorProtocol {

    var fetchSavedSelectionCalled = false
    var uploadDocumentCalled = false
    var sendEventUploadDocumentSuccessfullyCalled = false
    var sendEventFailToUploadDocumentCalled = false
    var uploadedImage: UIImage?

    func fetchSavedSelection() {
        fetchSavedSelectionCalled = true
    }

    func uploadDocument(_ image: UIImage) {
        uploadDocumentCalled = true
        uploadedImage = image
    }

    func sendEventUploadDocumentSuccessfully() {
        sendEventUploadDocumentSuccessfullyCalled = true
    }

    func sendEventFailToUploadDocument() {
        sendEventFailToUploadDocumentCalled = true
    }
}

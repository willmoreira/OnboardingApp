import UIKit
@testable import OnboardingApp
import CoreKit

final class MockDocumentCaptureInteractor: DocumentCaptureInteractorProtocol {

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

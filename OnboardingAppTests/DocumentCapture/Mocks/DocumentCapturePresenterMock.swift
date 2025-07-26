import Foundation
@testable import OnboardingApp

final class DocumentCapturePresenterMock: DocumentCaptureInteractorOutputProtocol {

    var didUploadSuccessfullyCalled = false
    var didFailToUploadCalled = false
    var retrievedSelection: UserSelectionEntity.UserEntity?

    func didRetrieveSelection(_ response: UserSelectionEntity.Response) {
        retrievedSelection = response.selection
    }

    func didUploadDocumentSuccessfully() {
        didUploadSuccessfullyCalled = true
    }

    func didFailToUploadDocument() {
        didFailToUploadCalled = true
    }
}

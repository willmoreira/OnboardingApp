import Foundation
@testable import OnboardingApp

final class DocumentCapturePresenterMock: DocumentCaptureInteractorOutputProtocol {

    private(set) var didUploadSuccessfullyCalled = false
    private(set) var didFailToUploadCalled = false
    private(set) var retrievedSelection: UserSelectionEntity.UserEntity?

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

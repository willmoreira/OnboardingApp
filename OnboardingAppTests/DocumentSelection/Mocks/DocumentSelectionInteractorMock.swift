import Foundation
@testable import OnboardingApp

final class DocumentSelectionInteractorMock: DocumentSelectionInteractorProtocol {

    var fetchDocumentsCalled = false
    var sendEventCalled = false
    var saveSelectedCalled = false

    var sentRequestForEvent: DocumentSelectionEntity.Request?
    var sentRequestForSave: DocumentSelectionEntity.Request?

    func fetchDocuments() {
        fetchDocumentsCalled = true
    }

    func sendEvent(request: DocumentSelectionEntity.Request) {
        sendEventCalled = true
        sentRequestForEvent = request
    }

    func saveSelectedCountryAndDocument(request: DocumentSelectionEntity.Request) {
        saveSelectedCalled = true
        sentRequestForSave = request
    }
}

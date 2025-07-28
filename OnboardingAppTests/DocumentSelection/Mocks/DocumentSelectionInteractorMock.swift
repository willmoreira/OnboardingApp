import Foundation
@testable import OnboardingApp

final class DocumentSelectionInteractorMock: DocumentSelectionInteractorProtocol {

    private(set) var fetchDocumentsCalled = false
    private(set) var sendEventCalled = false
    private(set) var saveSelectedCalled = false

    private(set) var sentRequestForEvent: DocumentSelectionEntity.Request?
    private(set) var sentRequestForSave: DocumentSelectionEntity.Request?

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

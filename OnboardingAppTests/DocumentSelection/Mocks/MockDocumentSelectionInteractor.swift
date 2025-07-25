import Foundation
@testable import OnboardingApp
import CoreKit

final class MockDocumentSelectionInteractor: DocumentSelectionInteractorProtocol {
    var fetchDocumentsCalled = false
    var sendEventCalled = false
    var sentCountry: Country?
    var sentDocument: Document?

    func fetchDocuments() {
        fetchDocumentsCalled = true
    }

    func sendEvent(country: Country, document: Document) {
        sendEventCalled = true
        sentCountry = country
        sentDocument = document
    }
}

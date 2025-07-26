import Foundation
@testable import OnboardingApp

final class MockDocumentSelectionInteractor: DocumentSelectionInteractorProtocol {
    
    var fetchDocumentsCalled = false
    var sendEventCalled = false
    var sentCountry: CountrySelectionEntity?
    var sentDocument: DocumentSelectionUserEntity?
    var savedCountry: CountrySelectionEntity?
    var savedDocument: DocumentSelectionUserEntity?

    func fetchDocuments() {
        fetchDocumentsCalled = true
    }

    func sendEvent(country: CountrySelectionEntity, document: DocumentSelectionUserEntity) {
        sendEventCalled = true
        sentCountry = country
        sentDocument = document
    }
    
    func saveSelectedCountryAndDocument(country: CountrySelectionEntity, document: DocumentSelectionUserEntity) {
        savedCountry = country
        savedDocument = document
    }
}

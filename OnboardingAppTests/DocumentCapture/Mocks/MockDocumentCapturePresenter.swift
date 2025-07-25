import Foundation
@testable import OnboardingApp
import CoreKit

final class MockDocumentCapturePresenter: DocumentCaptureInteractorOutputProtocol {
    
    var didUploadSuccessfullyCalled = false
    var didFailToUploadCalled = false
    var retrievedCountry: Country?
    var retrievedDocument: Document?

    func didUploadDocumentSuccessfully() { didUploadSuccessfullyCalled = true }
    func didFailToUploadDocument() { didFailToUploadCalled = true }
    func didRetrieveSelection(country: Country, document: Document) {
        retrievedCountry = country
        retrievedDocument = document
    }
}

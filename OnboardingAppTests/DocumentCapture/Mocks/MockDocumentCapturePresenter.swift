import Foundation
@testable import OnboardingApp

final class MockDocumentCapturePresenter: DocumentCaptureInteractorOutputProtocol {

    var didUploadSuccessfullyCalled = false
    var didFailToUploadCalled = false
    var retrievedCountry: CountrySelectionEntity?
    var retrievedDocument: DocumentSelectionUserEntity?

    func didUploadDocumentSuccessfully() { didUploadSuccessfullyCalled = true }
    func didFailToUploadDocument() { didFailToUploadCalled = true }
    func didRetrieveSelection(country: CountrySelectionEntity, document: DocumentSelectionUserEntity) {
        retrievedCountry = country
        retrievedDocument = document
    }
}

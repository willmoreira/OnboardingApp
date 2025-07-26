import Foundation
@testable import OnboardingApp

final class MockDocumentSelectionPresenter: DocumentSelectionInteractorOutputProtocol {
    var receivedDocuments: [DocumentSelectionUserEntity] = []
    var receivedCountry: CountrySelectionEntity?

    func didFetchDocuments(_ documents: [DocumentSelectionUserEntity], _ country: CountrySelectionEntity) {
        receivedDocuments = documents
        receivedCountry = country
    }
}

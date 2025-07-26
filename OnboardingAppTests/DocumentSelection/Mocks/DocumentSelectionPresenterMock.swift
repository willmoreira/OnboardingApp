import Foundation
@testable import OnboardingApp

final class DocumentSelectionPresenterMock: DocumentSelectionInteractorOutputProtocol {

    var receivedDocuments: [DocumentSelectionUserEntity] = []
    var receivedCountry: CountrySelectionEntity?

    func didFetchDocuments(_ documents: [DocumentSelectionUserEntity], _ country: CountrySelectionEntity) {
        receivedDocuments = documents
        receivedCountry = country
    }
}

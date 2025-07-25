import Foundation
@testable import OnboardingApp
import CoreKit

final class MockDocumentSelectionPresenter: DocumentSelectionInteractorOutputProtocol {
    var receivedDocuments: [Document] = []
    var receivedCountry: Country?

    func didFetchDocuments(_ documents: [Document], _ country: Country) {
        receivedDocuments = documents
        receivedCountry = country
    }
}

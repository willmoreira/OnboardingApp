import Foundation
@testable import OnboardingApp
import CoreKit

final class MockDocumentSelectionView: DocumentSelectionViewProtocol {
    var shownDocuments: [Document] = []
    var savedCountry: Country?
    var savedDocument: Document?

    func showDocuments(_ documents: [Document]) {
        shownDocuments = documents
    }

    func saveSelectedCountryAndDocument(country: Country, document: Document) {
        savedCountry = country
        savedDocument = document
    }
}

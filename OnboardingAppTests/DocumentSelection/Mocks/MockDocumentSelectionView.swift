import Foundation
@testable import OnboardingApp

final class MockDocumentSelectionView: DocumentSelectionViewProtocol {

    var shownDocuments: [DocumentSelectionUserEntity] = []

    func showDocuments(_ documents: [DocumentSelectionUserEntity]) {
        shownDocuments = documents
    }

}

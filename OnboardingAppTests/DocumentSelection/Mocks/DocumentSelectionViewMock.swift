import Foundation
@testable import OnboardingApp

final class DocumentSelectionViewMock: DocumentSelectionViewProtocol {

    var shownDocuments: [DocumentSelectionUserEntity] = []

    func showDocuments(_ documents: [DocumentSelectionUserEntity]) {
        shownDocuments = documents
    }
}

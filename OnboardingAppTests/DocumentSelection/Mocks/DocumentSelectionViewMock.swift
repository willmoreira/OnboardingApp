import Foundation
@testable import OnboardingApp

final class DocumentSelectionViewMock: DocumentSelectionViewProtocol {

    private(set) var shownViewModel: DocumentSelectionEntity.ViewModel?
    private(set) var shownDocuments: [DocumentSelectionEntity.UserEntity] = []

    func showDocuments(_ viewModel: DocumentSelectionEntity.ViewModel) {
        shownViewModel = viewModel
        shownDocuments = viewModel.documents
    }
}

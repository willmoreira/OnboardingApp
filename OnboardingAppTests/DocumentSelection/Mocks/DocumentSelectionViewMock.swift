import Foundation
@testable import OnboardingApp

final class DocumentSelectionViewMock: DocumentSelectionViewProtocol {

    var shownViewModel: DocumentSelectionEntity.ViewModel?
    var shownDocuments: [DocumentSelectionEntity.UserEntity] = []

    func showDocuments(_ viewModel: DocumentSelectionEntity.ViewModel) {
        shownViewModel = viewModel
        shownDocuments = viewModel.documents
    }
}

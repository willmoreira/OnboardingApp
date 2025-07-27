import Foundation
import UIKit

public final class DocumentSelectionPresenterUITestMock: DocumentSelectionPresenterProtocol {

    weak var view: DocumentSelectionViewProtocol?

    func viewDidLoad() {
        let docs = [
            DocumentSelectionEntity.UserEntity(name: "RG", iconName: "doc.text"),
            DocumentSelectionEntity.UserEntity(name: "CNH", iconName: "car.fill")
        ]

        let viewModel = DocumentSelectionEntity.ViewModel(documents: docs)
        view?.showDocuments(viewModel)
    }

    func didTapNext(with document: DocumentSelectionEntity.UserEntity) {}
}

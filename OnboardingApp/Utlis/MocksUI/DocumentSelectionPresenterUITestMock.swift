import Foundation
import UIKit

public final class DocumentSelectionPresenterUITestMock: DocumentSelectionPresenterProtocol {

    weak var view: DocumentSelectionViewProtocol?

    func viewDidLoad() {
        let docs = [
            DocumentSelectionUserEntity(name: "RG", iconName: "doc.text"),
            DocumentSelectionUserEntity(name: "CNH", iconName: "car.fill")
        ]
        view?.showDocuments(docs)
    }

    func didTapNext(with document: DocumentSelectionUserEntity) {
        // pode simular navegação ou log
    }
}

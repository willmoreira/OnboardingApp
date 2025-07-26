import Foundation
import UIKit

final class DocumentCapturePresenterUITestMock: DocumentCapturePresenterProtocol {

    weak var view: DocumentCaptureViewProtocol?

    func viewDidLoad() {
        let dummyCountry = CountrySelectionEntity(name: "Brasil", flagImageName: "br")
        let dummyDocument = DocumentSelectionUserEntity(name: "CNH", iconName: "car.fill")

        view?.displaySelectedCountry(dummyCountry.name)
        view?.displaySelectedDocument(dummyDocument.name)
    }

    func didTapCapture() {}
    func didTapSend() {}
    func didRetrieveSelection(country: CountrySelectionEntity, document: DocumentSelectionUserEntity) {}
}

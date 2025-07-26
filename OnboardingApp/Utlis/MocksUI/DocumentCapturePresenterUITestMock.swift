import Foundation
import UIKit

final class DocumentCapturePresenterUITestMock: DocumentCapturePresenterProtocol {

    weak var view: DocumentCaptureViewProtocol?

    func viewDidLoad() {
        let dummyCountry = CountrySelectionEntity(name: "Brasil", flagImageName: "br")
        let dummyDocument = DocumentSelectionUserEntity(name: "CNH", iconName: "car.fill")
        let dummyBirthDate = Calendar.current.date(byAdding: .year, value: -25, to: Date()) ?? Date()

        let selection = UserSelectionEntity(
            country: dummyCountry,
            document: dummyDocument,
            birthDate: dummyBirthDate
        )
        view?.displayUserSelection(selection)
    }

    func didTapCapture() {}
    func didTapSend() {}
    func didRetrieveSelection(_ selection: UserSelectionEntity) {}
}

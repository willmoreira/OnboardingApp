import Foundation
import UIKit

final class DocumentCapturePresenterUITestMock: DocumentCapturePresenterProtocol {

    weak var view: DocumentCaptureViewProtocol?

    func viewDidLoad() {
        let dummyCountry = CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "br")
        let dummyDocument = DocumentSelectionEntity.UserEntity(name: "CNH", iconName: "car.fill")
        let dummyBirthDate = Calendar.current.date(byAdding: .year, value: -25, to: Date()) ?? Date()

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let birthDateFormatted = formatter.string(from: dummyBirthDate)

        let viewModel = UserSelectionEntity.ViewModel(
            countryName: dummyCountry.name,
            documentName: dummyDocument.name,
            birthDateFormatted: birthDateFormatted
        )

        view?.displayUserSelection(viewModel)
    }

    func didTapCapture() {}
    func didTapSend() {}
    func didRetrieveSelection(_ selection: UserSelectionEntity) {}
    func didConfirmSuccess() {}
}

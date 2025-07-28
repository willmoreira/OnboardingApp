import UIKit
@testable import OnboardingApp

final class DocumentCaptureInteractorMock: DocumentCaptureInteractorProtocol {

    weak var presenter: DocumentCaptureInteractorOutputProtocol?

    private(set) var fetchSavedSelectionCalled = false
    private(set) var uploadDocumentCalled = false
    private(set) var sendEventUploadDocumentSuccessfullyCalled = false
    private(set) var sendEventFailToUploadDocumentCalled = false
    private(set) var uploadedImage: UIImage?

    func fetchSavedSelection() {
        fetchSavedSelectionCalled = true

        let dummyCountry = CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "br")
        let dummyDocument = DocumentSelectionEntity.UserEntity(name: "CNH", iconName: "car.fill")
        let dummyBirthDate = Calendar.current.date(byAdding: .year, value: -25, to: Date()) ?? Date()

        let userSelection = UserSelectionEntity.UserEntity(
            country: dummyCountry,
            document: dummyDocument,
            birthDate: dummyBirthDate
        )

        let response = UserSelectionEntity.Response(selection: userSelection)

        presenter?.didRetrieveSelection(response)
    }

    func uploadDocument(_ image: UIImage) {
        uploadDocumentCalled = true
        uploadedImage = image
    }

    func sendEventUploadDocumentSuccessfully() {
        sendEventUploadDocumentSuccessfullyCalled = true
    }

    func sendEventFailToUploadDocument() {
        sendEventFailToUploadDocumentCalled = true
    }
}

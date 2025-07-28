import UIKit

final class DocumentCaptureInteractor {

    // MARK: - Properties

    weak var presenter: DocumentCaptureInteractorOutputProtocol?
    private let uploadService: UploadServiceProtocol

    // MARK: - Initialization

    init(uploadService: UploadServiceProtocol) {
        self.uploadService = uploadService
    }
}

// MARK: - DocumentCaptureInteractorProtocol

extension DocumentCaptureInteractor: DocumentCaptureInteractorProtocol {

    func uploadDocument(_ image: UIImage) {

        uploadService.upload(image: image) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                self.presenter?.didUploadDocumentSuccessfully()
            case .failure:
                self.presenter?.didFailToUploadDocument()
            }
        }
    }

    func fetchSavedSelection() {
        guard
            let country = UserDefaults.standard.getDecodable(
                forKey: "selectedCountry",
                as: CountrySelectionEntity.UserEntity.self
            ),
            let document = UserDefaults.standard.getDecodable(
                forKey: "selectedDocument",
                as: DocumentSelectionEntity.UserEntity.self
            ),
            let birthDate = UserDefaults.standard.getDecodable(
                forKey: "birthDate",
                as: Date.self
            )
        else {
            return
        }

        let userEntity = UserSelectionEntity.UserEntity(country: country, document: document, birthDate: birthDate)
        let response = UserSelectionEntity.Response(selection: userEntity)
        presenter?.didRetrieveSelection(response)
    }
}

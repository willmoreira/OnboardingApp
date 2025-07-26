import UIKit

final class DocumentCaptureInteractor {

    // MARK: - Properties

    weak var presenter: DocumentCaptureInteractorOutputProtocol?
    private let uploadService: UploadServiceProtocol
    private let eventLogger: EventLogging

    // MARK: - Initialization

    init(uploadService: UploadServiceProtocol, eventLogger: EventLogging) {
        self.uploadService = uploadService
        self.eventLogger = eventLogger
    }
}

// MARK: - DocumentCaptureInteractorProtocol

extension DocumentCaptureInteractor: DocumentCaptureInteractorProtocol {

    func uploadDocument(_ image: UIImage) {

        eventLogger.sendEvent("send_document")

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
        guard let country = UserDefaults.standard.getDecodable(forKey: "selectedCountry", as: CountrySelectionEntity.self),
              let document = UserDefaults.standard.getDecodable(forKey: "selectedDocument", as: DocumentSelectionUserEntity.self),
              let birthDate = UserDefaults.standard.getDecodable(forKey: "birthDate", as: Date.self) else {
            return
        }

        let selection = UserSelectionEntity(
            country: country,
            document: document,
            birthDate: birthDate
        )

        presenter?.didRetrieveSelection(selection)
    }

    func sendEventUploadDocumentSuccessfully() {
        eventLogger.sendEvent("upload_document_successfully")
    }

    func sendEventFailToUploadDocument() {
        eventLogger.sendEvent("fail_to_upload_document")
    }
}

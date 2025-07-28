import UIKit

final class DocumentCapturePresenter {

    // MARK: - VIP Properties

    weak var view: DocumentCaptureViewProtocol?
    private let interactor: DocumentCaptureInteractorProtocol
    private let router: DocumentCaptureRouterProtocol
    private let eventLogger: EventLogging

    // MARK: - Properties

    var capturedImage: UIImage?
    var document: DocumentSelectionEntity.UserEntity?

    // MARK: - Initialization

    init(view: DocumentCaptureViewProtocol,
         interactor: DocumentCaptureInteractorProtocol,
         router: DocumentCaptureRouterProtocol,
         eventLogger: EventLogging) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.eventLogger = eventLogger
    }
}

// MARK: - DocumentCapturePresenterProtocol

extension DocumentCapturePresenter: DocumentCapturePresenterProtocol {

    func viewDidLoad() {
        interactor.fetchSavedSelection()
    }

    func didTapSend() {
        guard let image = capturedImage else {
            view?.showErrorMessage()
            return
        }

        view?.showLoading(true)
        eventLogger.sendEvent("send_document")
        interactor.uploadDocument(image)
    }

    func didTapCapture() {
        guard let document = document else {
            view?.showErrorMessage()
            return
        }

        let type = DocumentType(from: document)
        let imageName = type.imageName

        if let image = UIImage(named: imageName) {
            capturedImage = image
            view?.showCapturedImage(image)
        } else {
            view?.showSuccessMessage()
        }
    }

    func didConfirmSuccess() {
        router.restartFlow()
    }
}

// MARK: - DocumentCaptureInteractorOutputProtocol

extension DocumentCapturePresenter: DocumentCaptureInteractorOutputProtocol {

    func didRetrieveSelection(_ response: UserSelectionEntity.Response) {
        let selection = response.selection
        self.document = selection.document

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "pt_BR")

        let birthDateFormatted = formatter.string(from: selection.birthDate)

        let viewModel = UserSelectionEntity.ViewModel(
            countryName: selection.country.name,
            documentName: selection.document.name,
            birthDateFormatted: birthDateFormatted
        )

        view?.displayUserSelection(viewModel)
    }

    func didUploadDocumentSuccessfully() {
        eventLogger.sendEvent("upload_document_successfully")
        view?.showLoading(false)
        view?.showSuccessMessage()
    }

    func didFailToUploadDocument() {
        eventLogger.sendEvent("fail_to_upload_document")
        view?.showLoading(false)
        view?.showErrorMessage()
    }
}

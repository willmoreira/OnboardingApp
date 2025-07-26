import UIKit

final class DocumentCapturePresenter {

    // MARK: - VIP Properties

    weak var view: DocumentCaptureViewProtocol?
    private let interactor: DocumentCaptureInteractorProtocol
    private let router: DocumentCaptureRouterProtocol

    // MARK: - Properties

    private var capturedImage: UIImage?
    private var document: DocumentSelectionEntity.UserEntity?

    // MARK: - Initialization

    init(view: DocumentCaptureViewProtocol,
         interactor: DocumentCaptureInteractorProtocol,
         router: DocumentCaptureRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
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
}

// MARK: - DocumentCaptureInteractorOutputProtocol

extension DocumentCapturePresenter: DocumentCaptureInteractorOutputProtocol {

    func didRetrieveSelection(_ response: UserSelectionEntity.Response) {
        let selection = response.selection
        self.document = selection.document

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let birthDateFormatted = formatter.string(from: selection.birthDate)

        let viewModel = UserSelectionEntity.ViewModel(
            countryName: selection.country.name,
            documentName: selection.document.name,
            birthDateFormatted: birthDateFormatted
        )

        view?.displayUserSelection(viewModel)
    }

    func didUploadDocumentSuccessfully() {
        view?.showLoading(false)
        interactor.sendEventUploadDocumentSuccessfully()
        view?.showSuccessMessage()
    }

    func didFailToUploadDocument() {
        view?.showLoading(false)
        interactor.sendEventFailToUploadDocument()
        view?.showErrorMessage()
    }
}

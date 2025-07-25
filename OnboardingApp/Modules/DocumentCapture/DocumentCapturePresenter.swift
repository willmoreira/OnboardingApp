import UIKit

final class DocumentCapturePresenter {
    
    weak var view: DocumentCaptureViewProtocol?
    private let interactor: DocumentCaptureInteractorProtocol
    private let router: DocumentCaptureRouterProtocol

    private var capturedImage: UIImage?

    init(view: DocumentCaptureViewProtocol,
         interactor: DocumentCaptureInteractorProtocol,
         router: DocumentCaptureRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.fetchSavedSelection()
    }
}

extension DocumentCapturePresenter: DocumentCapturePresenterProtocol {
    func didTapCapture() {
        if let image = UIImage(named: "doc_sample") {
            capturedImage = image
            view?.showCapturedImage(image)
        } else {
            view?.showSuccessMessage()
        }
    }

    func didTapSend() {
        guard let image = capturedImage else {
            view?.showErrorMessage()
            return
        }

        view?.showLoading(true)
        interactor.uploadDocument(image)
    }

}

extension DocumentCapturePresenter: DocumentCaptureInteractorOutputProtocol {
   
    func didRetrieveSelection(country: Country, document: Document) {
        view?.displaySelectedCountry(country.name)
        view?.displaySelectedDocument(document.name)
    }
    
    func didUploadDocumentSuccessfully() {
        view?.showLoading(false)
        view?.showSuccessMessage()
    }

    func didFailToUploadDocument() {
        view?.showLoading(false)
        view?.showErrorMessage()
    }
}

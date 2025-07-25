import UIKit

protocol DocumentCaptureViewProtocol: AnyObject {
    func showCapturedImage(_ image: UIImage)
    func showLoading(_ show: Bool)
    func showSuccessMessage()
    func showErrorMessage()
    func displaySelectedCountry(_ name: String)
    func displaySelectedDocument(_ name: String)
}

protocol DocumentCapturePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapSend()
    func didTapCapture()
    func didRetrieveSelection(country: Country, document: Document)
}

protocol DocumentCaptureInteractorProtocol: AnyObject {
    func uploadDocument(_ image: UIImage)
    func fetchSavedSelection()
    func sendEventUploadDocumentSuccessfully()
    func sendEventFailToUploadDocument()
}

protocol DocumentCaptureInteractorOutputProtocol: AnyObject {
    func didRetrieveSelection(country: Country, document: Document)
    func didUploadDocumentSuccessfully()
    func didFailToUploadDocument()
}

protocol DocumentCaptureRouterProtocol: AnyObject {
    // futuro: navegar para próxima tela, se quiser
}

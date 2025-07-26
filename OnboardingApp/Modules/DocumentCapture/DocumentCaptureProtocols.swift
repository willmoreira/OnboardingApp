import UIKit

protocol DocumentCaptureViewProtocol: AnyObject {
    func showCapturedImage(_ image: UIImage)
    func showLoading(_ show: Bool)
    func showSuccessMessage()
    func showErrorMessage()
    func displayUserSelection(_ selection: UserSelectionEntity)
}

protocol DocumentCapturePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapSend()
    func didTapCapture()
}

protocol DocumentCaptureInteractorProtocol: AnyObject {
    func uploadDocument(_ image: UIImage)
    func fetchSavedSelection()
    func sendEventUploadDocumentSuccessfully()
    func sendEventFailToUploadDocument()
}

protocol DocumentCaptureInteractorOutputProtocol: AnyObject {
    func didRetrieveSelection(_ selection: UserSelectionEntity)
    func didUploadDocumentSuccessfully()
    func didFailToUploadDocument()
}

protocol DocumentCaptureRouterProtocol: AnyObject {
    // futuro: navegar para próxima tela, se quiser
}

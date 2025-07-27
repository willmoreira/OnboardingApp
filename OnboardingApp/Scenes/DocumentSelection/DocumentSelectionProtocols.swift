protocol DocumentSelectionViewProtocol: AnyObject {
    func showDocuments(_ viewModel: DocumentSelectionEntity.ViewModel)
}

protocol DocumentSelectionPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapNext(with document: DocumentSelectionEntity.UserEntity)
}

protocol DocumentSelectionInteractorProtocol: AnyObject {
    func fetchDocuments()
    func sendEvent(request: DocumentSelectionEntity.Request)
    func saveSelectedCountryAndDocument(request: DocumentSelectionEntity.Request)
}

protocol DocumentSelectionInteractorOutputProtocol: AnyObject {
    func didFetchDocuments(_ response: DocumentSelectionEntity.Response)
}

protocol DocumentSelectionRouterProtocol: AnyObject {
    func navigateToDocumentCapture()
}

protocol DocumentSelectionViewProtocol: AnyObject {
    func showDocuments(_ viewModel: DocumentSelectionEntity.ViewModel)
}

protocol DocumentSelectionPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapNext(with document: DocumentSelectionEntity.UserEntity)
}

protocol DocumentSelectionInteractorProtocol: AnyObject {
    func fetchDocuments()
    func saveSelectedCountryAndDocument(request: DocumentSelectionEntity.Request)
}

// swiftlint:disable:next type_name
protocol DocumentSelectionInteractorOutputProtocol: AnyObject {
    func didFetchDocuments(_ response: DocumentSelectionEntity.Response)
}

protocol DocumentSelectionRouterProtocol: AnyObject {
    func navigateToDocumentCapture()
}

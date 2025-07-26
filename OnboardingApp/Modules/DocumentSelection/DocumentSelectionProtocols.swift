protocol DocumentSelectionViewProtocol: AnyObject {
    func showDocuments(_ documents: [DocumentSelectionUserEntity])
}

protocol DocumentSelectionPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapNext(with document: DocumentSelectionUserEntity)
}

protocol DocumentSelectionInteractorProtocol: AnyObject {
    func fetchDocuments()
    func sendEvent(country: CountrySelectionEntity, document: DocumentSelectionUserEntity)
    func saveSelectedCountryAndDocument(country: CountrySelectionEntity, document: DocumentSelectionUserEntity)
}

// swiftlint:disable:next type_name
protocol DocumentSelectionInteractorOutputProtocol: AnyObject {
    func didFetchDocuments(_ documents: [DocumentSelectionUserEntity],_ country: CountrySelectionEntity)
}

protocol DocumentSelectionRouterProtocol: AnyObject {
    func navigateToDocumentCapture()
}

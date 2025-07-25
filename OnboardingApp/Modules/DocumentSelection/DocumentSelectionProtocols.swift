import CoreKit

protocol DocumentSelectionViewProtocol: AnyObject {
    func showDocuments(_ documents: [Document])
    func saveSelectedCountryAndDocument(country: Country, document: Document)
}

protocol DocumentSelectionPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapNext(with document: Document)
}

protocol DocumentSelectionInteractorProtocol: AnyObject {
    func fetchDocuments()
    func sendEvent(country: Country, document: Document)
}

protocol DocumentSelectionInteractorOutputProtocol: AnyObject {
    func didFetchDocuments(_ documents: [Document],_ country: Country)
}

protocol DocumentSelectionRouterProtocol: AnyObject {
    func navigateToDocumentCapture()
}

final class DocumentSelectionPresenter {
    
    // MARK: - VIP Properties

    weak var view: DocumentSelectionViewProtocol?
    private let interactor: DocumentSelectionInteractorProtocol
    private let router: DocumentSelectionRouterProtocol
    private var selectedCountry: Country?

    // MARK: - Initialization

    init(view: DocumentSelectionViewProtocol,
         interactor: DocumentSelectionInteractorProtocol,
         router: DocumentSelectionRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - DocumentSelectionPresenterProtocol

extension DocumentSelectionPresenter: DocumentSelectionPresenterProtocol {
        
    func viewDidLoad() {
        interactor.fetchDocuments()
    }
        
    func didTapNext(with document: Document) {
        guard let country = selectedCountry else { return }
        view?.saveSelectedCountryAndDocument(country: country, document: document)
        router.navigateToDocumentCapture()
    }
}

// MARK: - DocumentSelectionInteractorOutputProtocol

extension DocumentSelectionPresenter: DocumentSelectionInteractorOutputProtocol {
    
    func didFetchDocuments(_ documents: [Document], _ country: Country) {
        self.selectedCountry = country
        view?.showDocuments(documents)
    }
}

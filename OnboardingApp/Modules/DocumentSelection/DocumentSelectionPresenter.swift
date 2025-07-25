final class DocumentSelectionPresenter {
    
    weak var view: DocumentSelectionViewProtocol?
    private let interactor: DocumentSelectionInteractorProtocol
    private let router: DocumentSelectionRouterProtocol
    private var selectedCountry: Country?

    init(view: DocumentSelectionViewProtocol,
         interactor: DocumentSelectionInteractorProtocol,
         router: DocumentSelectionRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DocumentSelectionPresenter: DocumentSelectionPresenterProtocol {
    
    func viewDidLoad() {
        interactor.fetchDocuments()
    }
    
    func didTapNext(with document: Document) {
        guard let country = selectedCountry else { return }
        view?.saveSelectedCountryAndDocument(country: country, document: document)
        router.navigateToNextStep()
    }
}

extension DocumentSelectionPresenter: DocumentSelectionInteractorOutputProtocol {
    
    func didFetchDocuments(_ documents: [Document], _ country: Country) {
        self.selectedCountry = country
        view?.showDocuments(documents)
    }
}

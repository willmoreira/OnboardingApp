final class DocumentSelectionPresenter {

    // MARK: - VIP Properties

    weak var view: DocumentSelectionViewProtocol?
    private let interactor: DocumentSelectionInteractorProtocol
    private let router: DocumentSelectionRouterProtocol
    private var selectedCountry: CountrySelectionEntity?

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

    func didTapNext(with document: DocumentSelectionUserEntity) {
        guard let country = selectedCountry else { return }
        interactor.saveSelectedCountryAndDocument(country: country, document: document)
        interactor.sendEvent(country: country, document: document)
        router.navigateToDocumentCapture()
    }
}

// MARK: - DocumentSelectionInteractorOutputProtocol

extension DocumentSelectionPresenter: DocumentSelectionInteractorOutputProtocol {

    func didFetchDocuments(_ documents: [DocumentSelectionUserEntity], _ country: CountrySelectionEntity) {
        self.selectedCountry = country
        view?.showDocuments(documents)
    }
}

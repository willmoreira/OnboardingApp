final class DocumentSelectionPresenter {

    // MARK: - VIP Properties

    weak var view: DocumentSelectionViewProtocol?
    private let interactor: DocumentSelectionInteractorProtocol
    private let router: DocumentSelectionRouterProtocol
    private var selectedCountry: CountrySelectionEntity.UserEntity?
    private let eventLogger: EventLogging

    // MARK: - Initialization

    init(view: DocumentSelectionViewProtocol,
         interactor: DocumentSelectionInteractorProtocol,
         router: DocumentSelectionRouterProtocol,
         eventLogger: EventLogging) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.eventLogger = eventLogger
    }
}

// MARK: - DocumentSelectionPresenterProtocol

extension DocumentSelectionPresenter: DocumentSelectionPresenterProtocol {

    func viewDidLoad() {
        interactor.fetchDocuments()
    }

    func didTapNext(with document: DocumentSelectionEntity.UserEntity) {
        let request = DocumentSelectionEntity.Request(entity: document)
        interactor.saveSelectedCountryAndDocument(request: request)
        router.navigateToDocumentCapture()
        eventLogger.sendEvent(
            "tapped_select_document",
            parameters: ["document": request.entity.name]
        )
    }
}

// MARK: - DocumentSelectionInteractorOutputProtocol

extension DocumentSelectionPresenter: DocumentSelectionInteractorOutputProtocol {

    func didFetchDocuments(_ response: DocumentSelectionEntity.Response) {
        self.selectedCountry = countryFromResponse(response)
        let viewModel = DocumentSelectionEntity.ViewModel(documents: response.documents)
        view?.showDocuments(viewModel)
    }

    private func countryFromResponse(_ response: DocumentSelectionEntity.Response) -> CountrySelectionEntity.UserEntity? {
        return selectedCountry
    }
}

final class CountrySelectionPresenter {

    // MARK: - VIP Properties

    weak var view: CountrySelectionViewProtocol?
    var interactor: CountrySelectionInteractorProtocol
    var router: CountrySelectionRouterProtocol
    private let eventLogger: EventLogging

    // MARK: - Initialization

    init(view: CountrySelectionViewProtocol,
         interactor: CountrySelectionInteractorProtocol,
         router: CountrySelectionRouterProtocol,
         eventLogger: EventLogging) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.eventLogger = eventLogger
    }
}

// MARK: - CountrySelectionPresenterProtocol

extension CountrySelectionPresenter: CountrySelectionPresenterProtocol {

    func viewDidLoad() {
        let request = CountrySelectionEntity.Request(entity: CountrySelectionEntity.UserEntity(name: "", flagImageName: ""))
        interactor.fetchCountries(request: request)
    }

    func didTapNext(with request: CountrySelectionEntity.Request) {
        eventLogger.sendEvent("tapped_select_country", parameters: ["country": request.entity.name])
        router.navigateToDocumentSelection(with: request.entity)
    }
}

// MARK: - CountrySelectionInteractorOutputProtocol

extension CountrySelectionPresenter: CountrySelectionInteractorOutputProtocol {

    func didFetchCountries(_ response: CountrySelectionEntity.Response) {
        let viewModel = CountrySelectionEntity.ViewModel(countries: response.countries)
        view?.showCountries(viewModel)
    }
}

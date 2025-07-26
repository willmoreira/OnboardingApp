final class CountrySelectionPresenter {

    // MARK: - VIP Properties

    weak var view: CountrySelectionViewProtocol?
    var interactor: CountrySelectionInteractorProtocol
    var router: CountrySelectionRouterProtocol

    // MARK: - Initialization

    init(view: CountrySelectionViewProtocol,
         interactor: CountrySelectionInteractorProtocol,
         router: CountrySelectionRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - CountrySelectionPresenterProtocol

extension CountrySelectionPresenter: CountrySelectionPresenterProtocol {

    func viewDidLoad() {
        // Cria um request vazio (sem filtro, por exemplo)
        let request = CountrySelectionEntity.Request(entity: CountrySelectionEntity.UserEntity(name: "", flagImageName: ""))
        interactor.fetchCountries(request: request)
    }

    func didTapNext(with request: CountrySelectionEntity.Request) {
        interactor.sendEventTap(with: request)
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

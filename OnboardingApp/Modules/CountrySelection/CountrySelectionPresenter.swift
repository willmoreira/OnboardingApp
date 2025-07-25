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
        interactor.fetchCountries()
    }

    func didTapNext(with country: Country) {
        router.navigateToDocumentSelection(with: country)
    }
}

// MARK: - CountrySelectionInteractorOutputProtocol

extension CountrySelectionPresenter: CountrySelectionInteractorOutputProtocol {
    
    func didFetchCountries(_ countries: [Country]) {
        view?.showCountries(countries)
    }
}


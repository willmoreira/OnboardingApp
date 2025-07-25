import Foundation

final class CountrySelectionPresenter: CountrySelectionPresenterProtocol {
    weak var view: CountrySelectionViewProtocol?
    var interactor: CountrySelectionInteractorProtocol
    var router: CountrySelectionRouterProtocol

    init(view: CountrySelectionViewProtocol,
         interactor: CountrySelectionInteractorProtocol,
         router: CountrySelectionRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor.fetchCountries()
    }

    func didFetchCountries(_ countries: [Country]) {
        view?.showCountries(countries)
    }
    
    func didTapNext(with country: Country) {
        router.navigateToNextStep(with: country)
    }
}

protocol CountrySelectionViewProtocol: AnyObject {
    func showCountries(_ countries: [Country])
}

protocol CountrySelectionInteractorProtocol: AnyObject {
    func fetchCountries()
    func sendEventTap(with country: Country)
}

protocol CountrySelectionPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapNext(with country: Country)
}

protocol CountrySelectionInteractorOutputProtocol: AnyObject {
    func didFetchCountries(_ countries: [Country])
}

protocol CountrySelectionRouterProtocol: AnyObject {
    func navigateToDocumentSelection(with country: Country)
}

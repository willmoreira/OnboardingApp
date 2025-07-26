protocol CountrySelectionViewProtocol: AnyObject {
    func showCountries(_ countries: [CountrySelectionEntity])
}

protocol CountrySelectionInteractorProtocol: AnyObject {
    func fetchCountries()
    func sendEventTap(with country: CountrySelectionEntity)
}

protocol CountrySelectionPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapNext(with country: CountrySelectionEntity)
}

protocol CountrySelectionInteractorOutputProtocol: AnyObject {
    func didFetchCountries(_ countries: [CountrySelectionEntity])
}

protocol CountrySelectionRouterProtocol: AnyObject {
    func navigateToDocumentSelection(with country: CountrySelectionEntity)
}

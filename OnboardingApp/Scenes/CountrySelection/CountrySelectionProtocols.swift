protocol CountrySelectionViewProtocol: AnyObject {
    func showCountries(_ viewModel: CountrySelectionEntity.ViewModel)
}

protocol CountrySelectionInteractorProtocol: AnyObject {
    func fetchCountries(request: CountrySelectionEntity.Request)
}

protocol CountrySelectionPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapNext(with request: CountrySelectionEntity.Request)
}

protocol CountrySelectionInteractorOutputProtocol: AnyObject {
    func didFetchCountries(_ response: CountrySelectionEntity.Response)
}

protocol CountrySelectionRouterProtocol: AnyObject {
    func navigateToDocumentSelection(with country: CountrySelectionEntity.UserEntity)
}

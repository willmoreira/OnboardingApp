protocol BirthDateViewProtocol: AnyObject {
    func displayValidation(_ viewModel: BirthDateEntity.ViewModel)
}

protocol BirthDateInteractorProtocol: AnyObject {
    func validateBirthDate(_ request: BirthDateEntity.Request)
    func saveBirthDate()
}

protocol BirthDateProtocols: AnyObject {
    func showCountries(_ countries: [CountrySelectionEntity])
}

protocol BirthDatePresenterProtocol: AnyObject {
    func validateBirthDate(_ request: BirthDateEntity.Request)
    func goToDocumentCapture()
}

protocol BirthDateInteractorOutputProtocol: AnyObject {
    func presentValidation(_ response: BirthDateEntity.Response)
}

protocol BirthDateRouterProtocol: AnyObject {
    func routeToDocumentCapture()
}

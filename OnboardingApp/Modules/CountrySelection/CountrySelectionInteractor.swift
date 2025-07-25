final class CountrySelectionInteractor {
    
    // MARK: - Properties
    
    weak var presenter: CountrySelectionPresenter?
}

// MARK: - CountrySelectionInteractorProtocol

extension CountrySelectionInteractor: CountrySelectionInteractorProtocol {
    
    func fetchCountries() {
        let mockCountries = [
            Country(name: "Brasil", flagImageName: "br"),
            Country(name: "Estados Unidos", flagImageName: "us"),
            Country(name: "Reino Unido", flagImageName: "gb"),
            Country(name: "Alemanha", flagImageName: "de"),
            Country(name: "Japão", flagImageName: "jp"),
        ]
        presenter?.didFetchCountries(mockCountries)
    }
}

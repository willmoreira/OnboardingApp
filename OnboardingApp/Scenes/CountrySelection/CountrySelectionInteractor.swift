final class CountrySelectionInteractor {

    // MARK: - Properties

    weak var presenter: CountrySelectionInteractorOutputProtocol?
}

// MARK: - CountrySelectionInteractorProtocol

extension CountrySelectionInteractor: CountrySelectionInteractorProtocol {

    func fetchCountries(request: CountrySelectionEntity.Request) {
        let mockCountries: [CountrySelectionEntity.UserEntity] = [
            .init(name: "Brasil", flagImageName: "br"),
            .init(name: "Estados Unidos", flagImageName: "us"),
            .init(name: "Reino Unido", flagImageName: "gb"),
            .init(name: "Alemanha", flagImageName: "de"),
            .init(name: "Japão", flagImageName: "jp")
        ]

        let response = CountrySelectionEntity.Response(countries: mockCountries)

        presenter?.didFetchCountries(response)
    }
}

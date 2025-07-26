import Foundation

final class CountrySelectionInteractorMock: CountrySelectionInteractorProtocol {

    var output: CountrySelectionInteractorOutputProtocol?

    private(set) var fetchCountriesCalled = false
    private(set) var didSelectCountryCalled = false
    private(set) var selectedCountry: CountrySelectionEntity?

    func fetchCountries() {
        fetchCountriesCalled = true

        let mockCountries = [
            CountrySelectionEntity(name: "Brasil", flagImageName: "BR"),
            CountrySelectionEntity(name: "Estados Unidos", flagImageName: "US")
        ]

        output?.didFetchCountries(mockCountries)
    }

    func didSelectCountry(_ country: CountrySelectionEntity) {
        didSelectCountryCalled = true
        selectedCountry = country
    }

    func sendEventTap(with country: CountrySelectionEntity) {}
}

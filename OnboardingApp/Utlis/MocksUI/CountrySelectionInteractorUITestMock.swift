import Foundation

final class CountrySelectionInteractorMock: CountrySelectionInteractorProtocol {

    var output: CountrySelectionInteractorOutputProtocol?

    private(set) var fetchCountriesCalled = false
    private(set) var sendEventTapCalled = false
    private(set) var selectedCountry: CountrySelectionEntity.UserEntity?

    func fetchCountries(request: CountrySelectionEntity.Request) {
        fetchCountriesCalled = true

        let mockCountries = [
            CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "BR"),
            CountrySelectionEntity.UserEntity(name: "Estados Unidos", flagImageName: "US")
        ]

        let response = CountrySelectionEntity.Response(countries: mockCountries)
        output?.didFetchCountries(response)
    }

    func sendEventTap(with request: CountrySelectionEntity.Request) {
        sendEventTapCalled = true
        selectedCountry = request.entity
    }
}

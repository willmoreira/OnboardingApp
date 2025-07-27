import Foundation
@testable import OnboardingApp

final class CountrySelectionInteractorMock: CountrySelectionInteractorProtocol {

    private(set) var fetchCountriesCalled = false
    private(set) var sendEventCalled = false
    private(set) var sentCountry: CountrySelectionEntity.UserEntity?

    weak var presenter: CountrySelectionInteractorOutputProtocol?

    func fetchCountries(request: CountrySelectionEntity.Request) {
        fetchCountriesCalled = true

        let mockCountries = [
            CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "br"),
            CountrySelectionEntity.UserEntity(name: "Estados Unidos", flagImageName: "us")
        ]
        let response = CountrySelectionEntity.Response(countries: mockCountries)
        presenter?.didFetchCountries(response)
    }

    func sendEventTap(with request: CountrySelectionEntity.Request) {
        sendEventCalled = true
        sentCountry = request.entity
    }
}

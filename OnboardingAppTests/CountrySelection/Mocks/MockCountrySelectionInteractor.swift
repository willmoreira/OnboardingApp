import Foundation
@testable import OnboardingApp

final class MockCountrySelectionInteractor: CountrySelectionInteractorProtocol {
    private(set) var fetchCountriesCalled = false
    private(set) var sendEventCalled = false
    private(set) var sentCountry: CountrySelectionEntity?

    func fetchCountries() {
        fetchCountriesCalled = true
    }

    func sendEventTap(with country: CountrySelectionEntity) {
        sendEventCalled = true
        sentCountry = country
    }
}

import Foundation
@testable import OnboardingApp
import CoreKit

final class MockCountrySelectionInteractor: CountrySelectionInteractorProtocol {
    private(set) var fetchCountriesCalled = false
    private(set) var sendEventCalled = false
    private(set) var sentCountry: Country?

    func fetchCountries() {
        fetchCountriesCalled = true
    }

    func sendEventTap(with country: Country) {
        sendEventCalled = true
        sentCountry = country
    }
}

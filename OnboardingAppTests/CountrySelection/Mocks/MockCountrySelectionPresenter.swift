import Foundation
@testable import OnboardingApp
import CoreKit

final class MockCountrySelectionPresenter: CountrySelectionInteractorOutputProtocol {
    private(set) var fetchedCountries: [Country] = []

    func didFetchCountries(_ countries: [Country]) {
        fetchedCountries = countries
    }
}



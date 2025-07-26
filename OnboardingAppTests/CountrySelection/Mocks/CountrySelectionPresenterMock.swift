import Foundation
@testable import OnboardingApp

final class CountrySelectionPresenterMock: CountrySelectionInteractorOutputProtocol {
    private(set) var fetchedCountries: [CountrySelectionEntity] = []

    func didFetchCountries(_ countries: [CountrySelectionEntity]) {
        fetchedCountries = countries
    }
}

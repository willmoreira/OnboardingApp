import Foundation
@testable import OnboardingApp

final class CountrySelectionPresenterMock: CountrySelectionInteractorOutputProtocol {

    private(set) var fetchedCountries: [CountrySelectionEntity.UserEntity] = []

    func didFetchCountries(_ response: CountrySelectionEntity.Response) {
        fetchedCountries = response.countries
    }
}

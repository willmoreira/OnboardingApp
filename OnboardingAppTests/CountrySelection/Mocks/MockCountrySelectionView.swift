import Foundation
@testable import OnboardingApp

final class MockCountrySelectionView: CountrySelectionViewProtocol {
    private(set) var shownCountries: [CountrySelectionEntity] = []

    func showCountries(_ countries: [CountrySelectionEntity]) {
        shownCountries = countries
    }
}

import Foundation
@testable import OnboardingApp
import CoreKit

final class MockCountrySelectionView: CountrySelectionViewProtocol {
    private(set) var shownCountries: [Country] = []

    func showCountries(_ countries: [Country]) {
        shownCountries = countries
    }
}

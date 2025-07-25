import Foundation
@testable import OnboardingApp
import CoreKit

final class MockCountrySelectionRouter: CountrySelectionRouterProtocol {
    private(set) var navigatedToDocumentSelection = false
    private(set) var selectedCountry: Country?

    func navigateToDocumentSelection(with country: Country) {
        navigatedToDocumentSelection = true
        selectedCountry = country
    }
}

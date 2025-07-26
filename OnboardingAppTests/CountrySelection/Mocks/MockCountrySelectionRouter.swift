import Foundation
@testable import OnboardingApp

final class MockCountrySelectionRouter: CountrySelectionRouterProtocol {
    private(set) var navigatedToDocumentSelection = false
    private(set) var selectedCountry: CountrySelectionEntity?

    func navigateToDocumentSelection(with country: CountrySelectionEntity) {
        navigatedToDocumentSelection = true
        selectedCountry = country
    }
}

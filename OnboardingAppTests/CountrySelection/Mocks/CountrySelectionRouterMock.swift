import Foundation
@testable import OnboardingApp

final class CountrySelectionRouterMock: CountrySelectionRouterProtocol {

    private(set) var navigatedToDocumentSelection = false
    private(set) var selectedCountry: CountrySelectionEntity.UserEntity?

    func navigateToDocumentSelection(with country: CountrySelectionEntity.UserEntity) {
        navigatedToDocumentSelection = true
        selectedCountry = country
    }
}

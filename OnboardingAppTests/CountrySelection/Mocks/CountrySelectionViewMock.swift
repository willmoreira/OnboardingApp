import Foundation
@testable import OnboardingApp

final class CountrySelectionViewMock: CountrySelectionViewProtocol {

    private(set) var shownCountries: [CountrySelectionEntity.UserEntity] = []

    func showCountries(_ viewModel: CountrySelectionEntity.ViewModel) {
        shownCountries = viewModel.countries
    }
}

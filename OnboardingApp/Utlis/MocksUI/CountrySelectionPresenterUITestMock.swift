import Foundation

final class CountrySelectionPresenterUITestMock: CountrySelectionPresenterProtocol {

    weak var view: CountrySelectionViewProtocol?

    func viewDidLoad() {
        let mockCountries = [
            CountrySelectionEntity(name: "Brasil", flagImageName: "br"),
            CountrySelectionEntity(name: "Estados Unidos", flagImageName: "us")
        ]
        view?.showCountries(mockCountries)
    }

    func didTapNext(with country: CountrySelectionEntity) {
        UserDefaults.standard.set(true, forKey: "didNavigate")
        UserDefaults.standard.set(country.name, forKey: "selectedCountry")
    }
}

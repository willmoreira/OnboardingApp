import Foundation

final class CountrySelectionInteractorMock: CountrySelectionInteractorProtocol {
    weak var output: CountrySelectionInteractorOutputProtocol?

    func fetchCountries() {
        let countries = [
            CountrySelectionEntity(name: "Brasil", flagImageName: "br"),
            CountrySelectionEntity(name: "Estados Unidos", flagImageName: "us")
        ]
        output?.didFetchCountries(countries)
    }

    func sendEventTap(with country: CountrySelectionEntity) {
        // pode simular algo ou deixar vazio
    }
}

final class CountrySelectionInteractor {

    // MARK: - Properties

    weak var presenter: CountrySelectionInteractorOutputProtocol?
    private let eventLogger: EventLogging

    // MARK: - Initialization

    init(eventLogger: EventLogging) {
        self.eventLogger = eventLogger
    }
}

// MARK: - CountrySelectionInteractorProtocol

extension CountrySelectionInteractor: CountrySelectionInteractorProtocol {

    func fetchCountries() {
        let mockCountries = [
            CountrySelectionEntity(name: "Brasil", flagImageName: "br"),
            CountrySelectionEntity(name: "Estados Unidos", flagImageName: "us"),
            CountrySelectionEntity(name: "Reino Unido", flagImageName: "gb"),
            CountrySelectionEntity(name: "Alemanha", flagImageName: "de"),
            CountrySelectionEntity(name: "Japão", flagImageName: "jp")
        ]
        presenter?.didFetchCountries(mockCountries)
    }

    func sendEventTap(with country: CountrySelectionEntity) {
        eventLogger.sendEvent("tapped_select_country", parameters: ["country": country.name])
    }
}

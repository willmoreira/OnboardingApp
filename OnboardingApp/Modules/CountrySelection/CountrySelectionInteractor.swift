import CoreKit

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
            Country(name: "Brasil", flagImageName: "br"),
            Country(name: "Estados Unidos", flagImageName: "us"),
            Country(name: "Reino Unido", flagImageName: "gb"),
            Country(name: "Alemanha", flagImageName: "de"),
            Country(name: "Japão", flagImageName: "jp"),
        ]
        presenter?.didFetchCountries(mockCountries)
    }
    
    func sendEventTap(with country: Country) {
        eventLogger.sendEvent("tapped_select_country", parameters: ["country": country.name])
    }
}

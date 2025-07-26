import UIKit

final class DocumentSelectionInteractor {

    // MARK: - Properties

    weak var presenter: DocumentSelectionInteractorOutputProtocol?
    private let country: CountrySelectionEntity
    private let eventLogger: EventLogging

    // MARK: - Initialization

    init(country: CountrySelectionEntity, eventLogger: EventLogging) {
        self.country = country
        self.eventLogger = eventLogger
    }
}

// MARK: - DocumentSelectionInteractorProtocol

extension DocumentSelectionInteractor: DocumentSelectionInteractorProtocol {

    func fetchDocuments() {
        let documents: [DocumentSelectionUserEntity]

        switch country.name {
        case "Brasil":
            documents = [
                DocumentSelectionUserEntity(name: "RG", iconName: "person.text.rectangle"),
                DocumentSelectionUserEntity(name: "CNH", iconName: "car.fill")
            ]
        case "Estados Unidos":
            documents = [
                DocumentSelectionUserEntity(name: "Driver License", iconName: "car.circle"),
                DocumentSelectionUserEntity(name: "Passport", iconName: "globe.americas.fill")
            ]
        default:
            documents = [
                DocumentSelectionUserEntity(name: "Passport", iconName: "globe")
            ]
        }

        presenter?.didFetchDocuments(documents, country)
    }

    func sendEvent(country: CountrySelectionEntity, document: DocumentSelectionUserEntity) {
        eventLogger.sendEvent("tapped_select_document", parameters: ["document": document.name])
    }

    func saveSelectedCountryAndDocument(country: CountrySelectionEntity, document: DocumentSelectionUserEntity) {
        UserDefaults.standard.setEncodable(country, forKey: "selectedCountry")
        UserDefaults.standard.setEncodable(document, forKey: "selectedDocument")
    }
}

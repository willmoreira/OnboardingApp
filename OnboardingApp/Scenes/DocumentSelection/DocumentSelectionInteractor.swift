import UIKit

final class DocumentSelectionInteractor {

    // MARK: - Properties

    weak var presenter: DocumentSelectionInteractorOutputProtocol?
    let country: CountrySelectionEntity.UserEntity

    // MARK: - Initialization

    init(country: CountrySelectionEntity.UserEntity) {
        self.country = country
    }
}

// MARK: - DocumentSelectionInteractorProtocol

extension DocumentSelectionInteractor: DocumentSelectionInteractorProtocol {

    func fetchDocuments() {
        let documents: [DocumentSelectionEntity.UserEntity]

        switch country.name {
        case "Brasil":
            documents = [
                .init(name: "RG", iconName: "person.text.rectangle"),
                .init(name: "CNH", iconName: "car.fill")
            ]
        case "Estados Unidos":
            documents = [
                .init(name: "Driver License", iconName: "car.fill"),
                .init(name: "Passport", iconName: "globe")
            ]
        default:
            documents = [
                .init(name: "Passport", iconName: "globe")
            ]
        }

        let response = DocumentSelectionEntity.Response(documents: documents)
        presenter?.didFetchDocuments(response)
    }

    func saveSelectedCountryAndDocument(request: DocumentSelectionEntity.Request) {
        UserDefaults.standard.setEncodable(country, forKey: "selectedCountry")
        UserDefaults.standard.setEncodable(request.entity, forKey: "selectedDocument")
    }
}

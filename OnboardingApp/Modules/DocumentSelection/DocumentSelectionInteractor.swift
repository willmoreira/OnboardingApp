final class DocumentSelectionInteractor {
    
    // MARK: - Properties

    weak var presenter: DocumentSelectionInteractorOutputProtocol?
    private let country: Country

    // MARK: - Initialization

    init(country: Country) {
        self.country = country
    }
}

// MARK: - DocumentSelectionInteractorProtocol

extension DocumentSelectionInteractor: DocumentSelectionInteractorProtocol {
    
    func fetchDocuments() {
        let documents: [Document]

        switch country.name {
        case "Brasil":
            documents = [
                Document(name: "RG", iconName: "person.text.rectangle"),
                Document(name: "CNH", iconName: "car.fill")
            ]
        case "Estados Unidos":
            documents = [
                Document(name: "Driver License", iconName: "car.circle"),
                Document(name: "Passaporte", iconName: "globe.americas.fill")
            ]
        default:
            documents = [
                Document(name: "Passport", iconName: "globe")
            ]
        }

        presenter?.didFetchDocuments(documents, country)
    }
}

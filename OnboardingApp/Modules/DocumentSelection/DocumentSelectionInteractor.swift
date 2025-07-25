

final class DocumentSelectionInteractor: DocumentSelectionInteractorProtocol {
    weak var presenter: DocumentSelectionInteractorOutputProtocol?
    private let country: Country

    init(country: Country) {
        self.country = country
    }

    func fetchDocuments() {
        // Aqui você simula com base no país selecionado
        let documents: [Document]

        switch country.name {
        case "Brasil":
            documents = [
                Document(name: "RG", iconName: "doc_rg"),
                Document(name: "CNH", iconName: "doc_cnh")
            ]
        case "Estados Unidos":
            documents = [
                Document(name: "Driver License", iconName: "doc_dl"),
                Document(name: "Passport", iconName: "doc_passport")
            ]
        default:
            documents = [
                Document(name: "Passport", iconName: "doc_passport")
            ]
        }

        presenter?.didFetchDocuments(documents, country)
    }
}

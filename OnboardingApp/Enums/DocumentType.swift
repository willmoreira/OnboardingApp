enum DocumentType: String {
    case cnh = "CNH"
    case register = "RG"
    case passport = "Passport"

    var imageName: String {
        switch self {
        case .cnh:
            return "doc_cnh"
        case .register:
            return "doc_rg"
        case .passport:
            return "doc_passport"
        }
    }

    init(from document: DocumentSelectionEntity.UserEntity?) {
        self = DocumentType(rawValue: document?.name ?? "") ?? .passport
    }
}

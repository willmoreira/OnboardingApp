import CoreKit

enum DocumentType: String {
    case cnh = "CNH"
    case rg = "RG"
    case passport = "Passport"

    var imageName: String {
        switch self {
        case .cnh:
            return "doc_cnh"
        case .rg:
            return "doc_rg"
        case .passport:
            return "doc_passport"
        }
    }

    init(from document: Document?) {
        self = DocumentType(rawValue: document?.name ?? "") ?? .passport
    }
}

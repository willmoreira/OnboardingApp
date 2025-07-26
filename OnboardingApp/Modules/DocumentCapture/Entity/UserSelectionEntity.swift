import Foundation

struct UserSelectionEntity: Codable, Equatable {

    let country: CountrySelectionEntity
    let document: DocumentSelectionUserEntity
    let birthDate: Date
}

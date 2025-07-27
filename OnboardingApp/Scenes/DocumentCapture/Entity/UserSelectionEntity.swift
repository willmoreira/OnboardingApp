import Foundation

public enum UserSelectionEntity {

    public struct UserEntity: Codable, Equatable {
        public let country: CountrySelectionEntity.UserEntity
        public let document: DocumentSelectionEntity.UserEntity
        public let birthDate: Date

        public init(
            country: CountrySelectionEntity.UserEntity,
            document: DocumentSelectionEntity.UserEntity,
            birthDate: Date
        ) {
            self.country = country
            self.document = document
            self.birthDate = birthDate
        }
    }

    public struct Request {
        public let entity: UserEntity

        public init(entity: UserEntity) {
            self.entity = entity
        }
    }

    public struct Response {
        public let selection: UserEntity

        public init(selection: UserEntity) {
            self.selection = selection
        }
    }

    public struct ViewModel {
        public let countryName: String
        public let documentName: String
        public let birthDateFormatted: String

        public init(countryName: String, documentName: String, birthDateFormatted: String) {
            self.countryName = countryName
            self.documentName = documentName
            self.birthDateFormatted = birthDateFormatted
        }
    }
}

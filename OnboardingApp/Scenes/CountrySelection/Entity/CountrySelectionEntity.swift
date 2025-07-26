import Foundation

public enum CountrySelectionEntity {

    public struct UserEntity: Codable, Equatable {
        public let name: String
        public let flagImageName: String

        public init(name: String, flagImageName: String) {
            self.name = name
            self.flagImageName = flagImageName
        }
    }

    public struct Request {
        public let entity: UserEntity

        public init(entity: UserEntity) {
            self.entity = entity
        }
    }

    public struct Response {
        public let countries: [UserEntity]

        public init(countries: [UserEntity]) {
            self.countries = countries
        }
    }

    public struct ViewModel {
        public let countries: [CountrySelectionEntity.UserEntity]

        public init(countries: [CountrySelectionEntity.UserEntity]) {
            self.countries = countries
        }
    }
}


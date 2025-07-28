import Foundation

public enum BirthDateEntity {

    public struct UserEntity: Codable, Equatable {
        public let date: Date

        public init(date: Date) {
            self.date = date
        }
    }

    public struct Request {
        public let entity: UserEntity

        public init(entity: UserEntity) {
            self.entity = entity
        }
    }

    public struct Response {
        public let isValid: Bool

        public init(isValid: Bool) {
            self.isValid = isValid
        }
    }

    public struct ViewModel {
        public let isValid: Bool

        public init(isValid: Bool) {
            self.isValid = isValid
        }
    }
}

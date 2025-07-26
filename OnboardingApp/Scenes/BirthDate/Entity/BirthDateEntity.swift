import Foundation

enum BirthDateEntity {
    struct UserEntity: Codable, Equatable {
        let date: Date
    }

    struct Request {
        let entity: UserEntity
    }

    struct Response {
        let isValid: Bool
    }

    struct ViewModel {
        let isValid: Bool
    }
}

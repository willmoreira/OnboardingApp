import Foundation

public enum DocumentSelectionEntity {

    public struct UserEntity: Codable, Equatable {
        public let name: String
        public let iconName: String

        public init(name: String, iconName: String) {
            self.name = name
            self.iconName = iconName
        }
    }

    public struct Request: Codable, Equatable {
        public let entity: UserEntity

        public init(entity: UserEntity) {
            self.entity = entity
        }
    }

    public struct Response: Codable, Equatable {
        public let documents: [UserEntity]

        public init(documents: [UserEntity]) {
            self.documents = documents
        }
    }

    public struct ViewModel: Equatable {
        public let documents: [DocumentSelectionEntity.UserEntity]

        public init(documents: [DocumentSelectionEntity.UserEntity]) {
            self.documents = documents
        }
    }
}

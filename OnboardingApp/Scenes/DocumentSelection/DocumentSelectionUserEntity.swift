import Foundation

public struct DocumentSelectionUserEntity: Codable, Equatable {

    public let name: String
    public let iconName: String

    public init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
    }
}

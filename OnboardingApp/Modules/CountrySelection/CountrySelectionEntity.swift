import Foundation

struct CountrySelectionEntity: Codable, Equatable {

    public let name: String
    public let flagImageName: String

    public init(name: String, flagImageName: String) {
        self.name = name
        self.flagImageName = flagImageName
    }
}

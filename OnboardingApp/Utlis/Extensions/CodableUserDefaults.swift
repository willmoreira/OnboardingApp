import UIKit

extension UserDefaults {
    func setEncodable<T: Encodable>(_ object: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(object) {
            self.set(data, forKey: key)
        }
    }

    func getDecodable<T: Decodable>(forKey key: String, as type: T.Type) -> T? {
        guard let data = self.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

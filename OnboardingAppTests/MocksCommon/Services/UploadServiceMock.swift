import UIKit
@testable import OnboardingApp

final class UploadServiceMock: UploadServiceProtocol {

    var result: Result<Void, Error>?
    
    func upload(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}

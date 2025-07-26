import UIKit

protocol UploadServiceProtocol {
    func upload(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void)
}

final class UploadService: UploadServiceProtocol {

    func upload(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.success(()))
        }
    }
}

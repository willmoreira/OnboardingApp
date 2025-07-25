import UIKit

protocol UploadServiceProtocol {
    func upload(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void)
}

final class UploadService: UploadServiceProtocol {
    
    func upload(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

            let success = true

            if success {
                completion(.success(()))
            } else {
                //Como está forçando o sucesso, esse trecho nunca será executado
                let error = NSError(domain: "UploadError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Falha ao enviar o documento."])
                completion(.failure(error))
            }
        }
    }
}

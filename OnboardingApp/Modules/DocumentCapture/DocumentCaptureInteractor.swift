import UIKit

final class DocumentCaptureInteractor: DocumentCaptureInteractorProtocol {
    weak var presenter: DocumentCaptureInteractorOutputProtocol?
    
    private let uploadService: UploadServiceProtocol
    
    init(uploadService: UploadServiceProtocol) {
        self.uploadService = uploadService
    }

    func uploadDocument(_ image: UIImage) {
        uploadService.upload(image: image) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.presenter?.didUploadDocumentSuccessfully()
            case .failure:
                self.presenter?.didFailToUploadDocument()
            }
        }
    }
    
    func fetchSavedSelection() {
        guard let country = UserDefaults.standard.getDecodable(forKey: "selectedCountry", as: Country.self),
              let document = UserDefaults.standard.getDecodable(forKey: "selectedDocument", as: Document.self) else {
            return
        }
        
        presenter?.didRetrieveSelection(country: country, document: document)
    }
}

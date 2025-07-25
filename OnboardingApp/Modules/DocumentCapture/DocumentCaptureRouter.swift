import UIKit

final class DocumentCaptureRouter: DocumentCaptureRouterProtocol {
    
    weak var coordinator: AppCoordinator?

    static func createModule(coordinator: AppCoordinator) -> UIViewController {
        let view = DocumentCaptureViewController()
        let uploadService = UploadService()
        let interactor = DocumentCaptureInteractor(uploadService: uploadService)
        let router = DocumentCaptureRouter()
        let presenter = DocumentCapturePresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.coordinator = coordinator

        return view
    }
}

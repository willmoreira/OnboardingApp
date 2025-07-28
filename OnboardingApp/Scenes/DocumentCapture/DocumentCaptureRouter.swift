import UIKit

final class DocumentCaptureRouter {

    // MARK: - Properties

    weak var coordinator: AppCoordinator?

    // MARK: - Module Creation

    static func createModule(coordinator: AppCoordinator) -> UIViewController {
        let view = DocumentCaptureViewController()
        let uploadService = UploadService()
        let eventLogger = ConsoleEventLogger()
        let interactor = DocumentCaptureInteractor(uploadService: uploadService)
        let router = DocumentCaptureRouter()
        let presenter = DocumentCapturePresenter(
            view: view,
            interactor: interactor,
            router: router,
            eventLogger: eventLogger
        )

        view.presenter = presenter
        interactor.presenter = presenter
        router.coordinator = coordinator

        return view
    }
}

extension DocumentCaptureRouter: DocumentCaptureRouterProtocol {

    func restartFlow() {
        coordinator?.start()
    }
}

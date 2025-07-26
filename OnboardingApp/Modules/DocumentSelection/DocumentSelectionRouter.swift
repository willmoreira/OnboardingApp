import UIKit

final class DocumentSelectionRouter {

    // MARK: - Properties

    weak var coordinator: AppCoordinator?

    // MARK: - Module Creation

    static func createModule(
        coordinator: AppCoordinator,
        country: CountrySelectionEntity
    ) -> UIViewController {
        let view = DocumentSelectionViewController()
        let eventLogger = ConsoleEventLogger()
        let interactor = DocumentSelectionInteractor(country: country, eventLogger: eventLogger)
        let router = DocumentSelectionRouter()
        let presenter = DocumentSelectionPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.coordinator = coordinator

        return view
    }
}

// MARK: - DocumentSelectionRouterProtocol

extension DocumentSelectionRouter: DocumentSelectionRouterProtocol {

    func navigateToDocumentCapture() {
        coordinator?.goToBirthDate()
    }
}

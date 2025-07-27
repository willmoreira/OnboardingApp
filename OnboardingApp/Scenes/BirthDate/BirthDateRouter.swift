import UIKit

final class BirthDateRouter {

    // MARK: - Properties

    weak var viewController: UIViewController?
    var coordinator: AppCoordinator?

    // MARK: - Module Creation

    static func createModule(coordinator: AppCoordinator) -> UIViewController {
        let view = BirthDateViewController()
        let eventLogger = ConsoleEventLogger()
        let interactor = BirthDateInteractor(eventLogger: eventLogger)
        let router = BirthDateRouter()
        let presenter = BirthDatePresenter(
            view: view,
            interactor: interactor,
            router: router
        )

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        router.coordinator = coordinator

        return view
    }
}

// MARK: - BirthDateRouterProtocol

extension BirthDateRouter: BirthDateRouterProtocol {

    func routeToDocumentCapture() {
        coordinator?.goToDocumentCapture()
    }
}

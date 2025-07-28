import UIKit

final class CountrySelectionRouter {

    // MARK: - Properties

    weak var viewController: UIViewController?
    var coordinator: AppCoordinator?

    // MARK: - Module Creation

    static func createModule(coordinator: AppCoordinator) -> UIViewController {
        let view = CountrySelectionViewController()
        let eventLogger = ConsoleEventLogger()
        let interactor = CountrySelectionInteractor()
        let router = CountrySelectionRouter()
        let presenter = CountrySelectionPresenter(
            view: view,
            interactor: interactor,
            router: router,
            eventLogger: eventLogger
        )

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        router.coordinator = coordinator

        return view
    }
}

extension CountrySelectionRouter: CountrySelectionRouterProtocol {

    func navigateToDocumentSelection(with country: CountrySelectionEntity.UserEntity) {
        coordinator?.goToDocumentSelection(with: country)
    }
}

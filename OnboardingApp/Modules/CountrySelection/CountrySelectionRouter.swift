import UIKit

final class CountrySelectionRouter: CountrySelectionRouterProtocol {
    weak var viewController: UIViewController?
    var coordinator: AppCoordinator?

    static func createModule(coordinator: AppCoordinator) -> UIViewController {
        let view = CountrySelectionViewController()
        let interactor = CountrySelectionInteractor()
        let router = CountrySelectionRouter()
        let presenter = CountrySelectionPresenter(
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

    func navigateToNextStep(with country: Country) {
        coordinator?.goToDocumentSelection(with: country)
    }
}

import UIKit

final class DocumentSelectionRouter: DocumentSelectionRouterProtocol {
    weak var coordinator: AppCoordinator?

    static func createModule(coordinator: AppCoordinator, country: Country) -> UIViewController {
        let view = DocumentSelectionViewController()
        let interactor = DocumentSelectionInteractor(country: country)
        let router = DocumentSelectionRouter()
        let presenter = DocumentSelectionPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.coordinator = coordinator
        
        return view
    }

    func navigateToNextStep() {
        coordinator?.goToDocumentCapture()
    }
}

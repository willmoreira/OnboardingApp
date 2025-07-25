import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let module = CountrySelectionRouter.createModule(coordinator: self)
        navigationController.pushViewController(module, animated: true)
    }

    func goToDocumentSelection(with country: Country) {
        let module = DocumentSelectionRouter.createModule(coordinator: self, country: country)
        navigationController.pushViewController(module, animated: true)
    }
    
    func goToDocumentCapture() {
        let module = DocumentCaptureRouter.createModule(coordinator: self)
        navigationController.pushViewController(module, animated: true)
    }
}

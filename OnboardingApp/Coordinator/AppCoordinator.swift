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
        setCustomBackButton()
        let module = DocumentSelectionRouter.createModule(coordinator: self, country: country)
        navigationController.pushViewController(module, animated: true)
    }
    
    func goToDocumentCapture() {
        setCustomBackButton()
        let module = DocumentCaptureRouter.createModule(coordinator: self)
        navigationController.pushViewController(module, animated: true)
    }
    
    private func setCustomBackButton() {
        if let currentVC = navigationController.topViewController {
            let backButton = UIBarButtonItem()
            backButton.title = "Voltar"
            backButton.tintColor = .systemGreen
            currentVC.navigationItem.backBarButtonItem = backButton
        }
    }
}

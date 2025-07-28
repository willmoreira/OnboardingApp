import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        if CommandLine.arguments.contains("-UITestMode") {
            window.rootViewController = buildCountrySelectionUITest()
        } else if CommandLine.arguments.contains("-UITestDocumentSelection") {
            window.rootViewController = buildDocumentSelectionUITest()
        } else if CommandLine.arguments.contains("-UITestDocumentCapture") {
            window.rootViewController = buildDocumentCaptureUITest()
        } else if CommandLine.arguments.contains("-UITestBirthDate") {
            window.rootViewController = buildBirthDateViewControllerForUITest()
        } else {
            let navController = UINavigationController()
            appCoordinator = AppCoordinator(navigationController: navController)
            appCoordinator?.start()
            window.rootViewController = navController
        }

        window.makeKeyAndVisible()
    }

    func buildCountrySelectionUITest() -> UIViewController {
        let view = CountrySelectionViewController()
        let eventLogger = ConsoleEventLogger()
        let interactor = CountrySelectionInteractorMock()
        let router = CountrySelectionRouterMock(viewController: view)
        let presenter = CountrySelectionPresenter(
            view: view,
            interactor: interactor,
            router: router,
            eventLogger: eventLogger
        )

        interactor.output = presenter
        view.presenter = presenter

        return UINavigationController(rootViewController: view)
    }

    func buildDocumentSelectionUITest() -> UIViewController {
        let view = DocumentSelectionViewController()

        let presenter = DocumentSelectionPresenterUITestMock()
        presenter.view = view
        view.presenter = presenter

        return UINavigationController(rootViewController: view)
    }

    func buildBirthDateViewControllerForUITest() -> BirthDateViewController {
        let view = BirthDateViewController()

        let presenter = BirthDatePresenterUITestMock()
        presenter.view = view
        view.presenter = presenter

        return view
    }

    func buildDocumentCaptureUITest() -> UIViewController {
        let view = DocumentCaptureViewController()

        let presenter = DocumentCapturePresenterUITestMock()
        presenter.view = view
        view.presenter = presenter

        return view
    }
}

//
//  SceneDelegate.swift
//  OnboardingApp
//
//  Created by William on 24/07/25.
//

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
        } else {
            let navController = UINavigationController()
            appCoordinator = AppCoordinator(navigationController: navController)
            appCoordinator?.start()
            window.rootViewController = navController
        }

        window.makeKeyAndVisible()
    }

    func buildCountrySelectionUITest() -> UIViewController {
        let viewController = CountrySelectionViewController()

        let interactor = CountrySelectionInteractorMock()
        let router = CountrySelectionRouterMock(viewController: viewController)
        let presenter = CountrySelectionPresenter(
            view: viewController,
            interactor: interactor,
            router: router
        )

        interactor.output = presenter
        viewController.presenter = presenter

        return UINavigationController(rootViewController: viewController)
    }
}

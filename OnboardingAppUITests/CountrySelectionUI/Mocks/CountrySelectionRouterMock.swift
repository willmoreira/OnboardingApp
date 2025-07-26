import UIKit

final class CountrySelectionRouterMock: CountrySelectionRouterProtocol {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }

    func navigateToDocumentSelection(with country: CountrySelectionEntity) {
        let label = UILabel()
        label.text = "Documento"
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = "Documento"

        let nextVC = UIViewController()
        nextVC.view.backgroundColor = .white
        nextVC.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: nextVC.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: nextVC.view.centerYAnchor)
        ])

        viewController?.navigationController?.pushViewController(nextVC, animated: false)
    }
}

import UIKit

final class CountrySelectionRouterMock: CountrySelectionRouterProtocol {

    private(set) var navigateToDocumentSelectionCalled = false
    private let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func navigateToDocumentSelection(with country: CountrySelectionEntity) {
        navigateToDocumentSelectionCalled = true
    }
}

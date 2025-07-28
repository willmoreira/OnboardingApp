import Foundation

final class BirthDatePresenter {

    // MARK: - VIP Properties

    weak var view: BirthDateViewProtocol?

    var interactor: BirthDateInteractorProtocol
    var router: BirthDateRouterProtocol
    private let eventLogger: EventLogging

    // MARK: - Initialization

    init(view: BirthDateViewProtocol,
         interactor: BirthDateInteractorProtocol,
         router: BirthDateRouterProtocol,
         eventLogger: EventLogging
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.eventLogger = eventLogger
    }
}

// MARK: - BirthDatePresenterProtocol

extension BirthDatePresenter: BirthDatePresenterProtocol {

    func goToDocumentCapture() {
        interactor.saveBirthDate()
        eventLogger.sendEvent("tapped_go_to_document_capture")
        router.routeToDocumentCapture()
    }

    func validateBirthDate(_ request: BirthDateEntity.Request) {
        interactor.validateBirthDate(request)
    }
}

// MARK: - BirthDateInteractorOutputProtocol

extension BirthDatePresenter: BirthDateInteractorOutputProtocol {

    func presentValidation(_ response: BirthDateEntity.Response) {
        let viewModel = BirthDateEntity.ViewModel(isValid: response.isValid)
        view?.displayValidation(viewModel)
    }
}

import Foundation

final class BirthDateInteractor {

    // MARK: - Properties

    weak var presenter: BirthDateInteractorOutputProtocol?
    private let eventLogger: EventLogging
    private var birthday: Date?
    // MARK: - Initialization

    init(eventLogger: EventLogging) {
        self.eventLogger = eventLogger
    }
}

// MARK: - BirthDateInteractorProtocol

extension BirthDateInteractor: BirthDateInteractorProtocol {

    func validateBirthDate(_ request: BirthDateEntity.Request) {
        let calendar = Calendar.current
        guard let eighteenYearsAgo = calendar.date(byAdding: .year, value: -18, to: Date()) else {
            presenter?.presentValidation(BirthDateEntity.Response(isValid: false))
            return
        }

        let isValid = request.entity.date <= eighteenYearsAgo
        if isValid {
            birthday = request.entity.date
        }
        presenter?.presentValidation(BirthDateEntity.Response(isValid: isValid))
    }

    func saveBirthDate() {
        guard let birthday = birthday else { return }
        UserDefaults.standard.setEncodable(birthday, forKey: "birthDate")
    }
}

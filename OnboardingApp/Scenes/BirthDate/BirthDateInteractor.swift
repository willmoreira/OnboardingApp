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

    private var minimumAllowedDate: Date? {
        Calendar.current.date(byAdding: .year, value: -18, to: Date())
    }
}

// MARK: - BirthDateInteractorProtocol

extension BirthDateInteractor: BirthDateInteractorProtocol {

    func validateBirthDate(_ request: BirthDateEntity.Request) {
        guard let minDate = minimumAllowedDate else {
            presenter?.presentValidation(BirthDateEntity.Response(isValid: false))
            return
        }

        let isValid = request.entity.date <= minDate
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

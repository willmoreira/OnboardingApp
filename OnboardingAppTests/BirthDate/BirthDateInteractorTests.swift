import XCTest
@testable import OnboardingApp

final class BirthDateInteractorTests: XCTestCase {

    private var interactor: BirthDateInteractor!
    private var mockPresenter: BirthDatePresenterMock!
    private var mockLogger: EventLoggerMock!

    override func setUp() {
        super.setUp()
        mockPresenter = BirthDatePresenterMock()
        mockLogger = EventLoggerMock()
        interactor = BirthDateInteractor(eventLogger: mockLogger)
        interactor.presenter = mockPresenter
        UserDefaults.standard.removeObject(forKey: "birthDate")
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockLogger = nil
        super.tearDown()
    }

    func testValidateBirthDate_whenDateIsValid_shouldCallPresenterWithIsValidTrue() {
        // Arrange
        let validDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
        let request = BirthDateEntity.Request(entity: .init(date: validDate))

        // Act
        interactor.validateBirthDate(request)

        // Assert
        XCTAssertTrue(mockPresenter.presentValidationCalled)
        XCTAssertEqual(mockPresenter.receivedResponse?.isValid, true)
    }

    func testValidateBirthDate_whenDateIsInvalid_shouldCallPresenterWithIsValidFalse() {
        // Arrange
        let invalidDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
        let request = BirthDateEntity.Request(entity: .init(date: invalidDate))

        // Act
        interactor.validateBirthDate(request)

        // Assert
        XCTAssertTrue(mockPresenter.presentValidationCalled)
        XCTAssertEqual(mockPresenter.receivedResponse?.isValid, false)
    }

    func testSaveBirthDate_whenValidDateWasSet_shouldSaveToUserDefaults() {
        let validDate = Calendar.current.date(byAdding: .year, value: -25, to: Date())!
        let request = BirthDateEntity.Request(entity: .init(date: validDate))
        interactor.validateBirthDate(request)

        interactor.saveBirthDate()

        let savedDate = UserDefaults.standard.getDecodable(forKey: "birthDate", as: Date.self)

        guard let savedTime = savedDate?.timeIntervalSince1970 else {
            return XCTFail("savedDate should not be nil")
        }

        XCTAssertEqual(savedTime, validDate.timeIntervalSince1970, accuracy: 1)
    }

    func testSaveBirthDate_whenNoDateWasValidated_shouldNotSave() {
        // Act
        interactor.saveBirthDate()

        // Assert
        let savedDate = UserDefaults.standard.getDecodable(forKey: "birthDate", as: Date.self)
        XCTAssertNil(savedDate)
    }
}

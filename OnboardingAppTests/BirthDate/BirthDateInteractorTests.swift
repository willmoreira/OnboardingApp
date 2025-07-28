import XCTest
@testable import OnboardingApp

final class BirthDateInteractorTests: XCTestCase {

    private var interactor: BirthDateInteractor!
    private var mockPresenter: BirthDatePresenterMock!

    override func setUp() {
        super.setUp()
        mockPresenter = BirthDatePresenterMock()
        interactor = BirthDateInteractor()
        interactor.presenter = mockPresenter
        UserDefaults.standard.removeObject(forKey: "birthDate")
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        super.tearDown()
    }

    func testValidateBirthDate_whenDateIsValid_shouldCallPresenterWithIsValidTrue() {
        // Given
        let validDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
        let request = BirthDateEntity.Request(entity: .init(date: validDate))

        // When
        interactor.validateBirthDate(request)

        // Then
        XCTAssertTrue(mockPresenter.presentValidationCalled)
        XCTAssertEqual(mockPresenter.receivedResponse?.isValid, true)
    }

    func testValidateBirthDate_whenDateIsInvalid_shouldCallPresenterWithIsValidFalse() {
        // Given
        let invalidDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
        let request = BirthDateEntity.Request(entity: .init(date: invalidDate))

        // When
        interactor.validateBirthDate(request)

        // Then
        XCTAssertTrue(mockPresenter.presentValidationCalled)
        XCTAssertEqual(mockPresenter.receivedResponse?.isValid, false)
    }

    func testSaveBirthDate_whenValidDateWasSet_shouldSaveToUserDefaults() {
        // Given
        let validDate = Calendar.current.date(byAdding: .year, value: -25, to: Date())!
        let request = BirthDateEntity.Request(entity: .init(date: validDate))
        interactor.validateBirthDate(request)

        // When
        interactor.saveBirthDate()

        // Then
        let savedDate = UserDefaults.standard.getDecodable(forKey: "birthDate", as: Date.self)

        guard let savedTime = savedDate?.timeIntervalSince1970 else {
            return XCTFail("savedDate should not be nil")
        }

        XCTAssertEqual(savedTime, validDate.timeIntervalSince1970, accuracy: 1)
    }

    func testSaveBirthDate_whenNoDateWasValidated_shouldNotSave() {
        // When
        interactor.saveBirthDate()

        // Then
        let savedDate = UserDefaults.standard.getDecodable(forKey: "birthDate", as: Date.self)
        XCTAssertNil(savedDate)
    }
}

import XCTest
@testable import OnboardingApp

final class BirthDatePresenterTests: XCTestCase {

    private var presenter: BirthDatePresenter!
    private var mockView: BirthDateViewMock!
    private var mockInteractor: BirthDateInteractorMock!
    private var mockRouter: BirthDateRouterMock!
    private var mockLogger: EventLoggerMock!

    override func setUp() {
        super.setUp()
        mockView = BirthDateViewMock()
        mockInteractor = BirthDateInteractorMock()
        mockRouter = BirthDateRouterMock()
        mockLogger = EventLoggerMock()
        presenter = BirthDatePresenter(
            view: mockView,
            interactor: mockInteractor,
            router: mockRouter,
            eventLogger: mockLogger
        )
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        mockLogger = nil
        super.tearDown()
    }

    func testValidateBirthDate_shouldCallInteractorWithRequest() {
        // Given
        let date = Calendar.current.date(byAdding: .year, value: -19, to: Date())!
        let request = BirthDateEntity.Request(entity: .init(date: date))

        // When
        presenter.validateBirthDate(request)

        // Then
        XCTAssertTrue(mockInteractor.validateCalled)
        XCTAssertEqual(mockInteractor.validateRequest?.entity.date, date)
    }

    func testGoToDocumentCapture_shouldCallSaveBirthDateAndRoute() {
        // When
        presenter.goToDocumentCapture()

        // Then
        XCTAssertTrue(mockInteractor.saveBirthDateCalled)
        XCTAssertTrue(mockRouter.routeToDocumentCaptureCalled)
    }

    func testPresentValidation_shouldCallViewWithCorrectViewModel() {
        // Given
        let response = BirthDateEntity.Response(isValid: true)

        // When
        presenter.presentValidation(response)

        // Then
        XCTAssertTrue(mockView.displayValidationCalled)
        XCTAssertEqual(mockView.receivedViewModel?.isValid, true)
    }
}

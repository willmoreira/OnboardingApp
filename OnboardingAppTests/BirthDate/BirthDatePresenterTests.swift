import XCTest
@testable import OnboardingApp

final class BirthDatePresenterTests: XCTestCase {

    private var presenter: BirthDatePresenter!
    private var mockView: BirthDateViewMock!
    private var mockInteractor: BirthDateInteractorMock!
    private var mockRouter: BirthDateRouterMock!

    override func setUp() {
        super.setUp()
        mockView = BirthDateViewMock()
        mockInteractor = BirthDateInteractorMock()
        mockRouter = BirthDateRouterMock()
        presenter = BirthDatePresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func testValidateBirthDate_shouldCallInteractorWithRequest() {
        // Arrange
        let date = Calendar.current.date(byAdding: .year, value: -19, to: Date())!
        let request = BirthDateEntity.Request(entity: .init(date: date))

        // Act
        presenter.validateBirthDate(request)

        // Assert
        XCTAssertTrue(mockInteractor.validateCalled)
        XCTAssertEqual(mockInteractor.validateRequest?.entity.date, date)
    }

    func testGoToDocumentCapture_shouldCallSaveBirthDateAndRoute() {
        // Act
        presenter.goToDocumentCapture()

        // Assert
        XCTAssertTrue(mockInteractor.saveBirthDateCalled)
        XCTAssertTrue(mockRouter.routeToDocumentCaptureCalled)
    }

    func testPresentValidation_shouldCallViewWithCorrectViewModel() {
        // Arrange
        let response = BirthDateEntity.Response(isValid: true)

        // Act
        presenter.presentValidation(response)

        // Assert
        XCTAssertTrue(mockView.displayValidationCalled)
        XCTAssertEqual(mockView.receivedViewModel?.isValid, true)
    }
}


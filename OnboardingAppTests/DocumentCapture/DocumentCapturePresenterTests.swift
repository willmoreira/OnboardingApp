import XCTest
@testable import OnboardingApp

final class DocumentCapturePresenterTests: XCTestCase {

    private var presenter: DocumentCapturePresenter!
    private var mockView: DocumentCaptureViewMock!
    private var mockInteractor: DocumentCaptureInteractorMock!
    private var mockRouter: DocumentCaptureRouterMock!

    override func setUp() {
        super.setUp()
        mockView = DocumentCaptureViewMock()
        mockInteractor = DocumentCaptureInteractorMock()
        mockRouter = DocumentCaptureRouterMock()
        presenter = DocumentCapturePresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func test_viewDidLoad_callsFetchSavedSelection() {
        // Given
        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(mockInteractor.fetchSavedSelectionCalled)
    }

    func test_didTapSend_withoutImage_showsError() {
        // Given
        // When
        presenter.didTapSend()

        // Then
        XCTAssertTrue(mockView.showErrorMessageCalled)
    }

    func test_didTapSend_withImage_uploadsDocument() {
        // Given
        presenter.didTapCapture()
        presenter.capturedImage = UIImage()

        // When
        presenter.didTapSend()

        // Then
        XCTAssertTrue(mockView.showLoadingCalled)
        XCTAssertTrue(mockInteractor.uploadDocumentCalled)
    }

    func test_didUploadDocumentSuccessfully_behaviour() {
        // Given
        // When
        presenter.didUploadDocumentSuccessfully()

        // Then
        XCTAssertTrue(mockView.hideLoadingCalled)
        XCTAssertTrue(mockInteractor.sendEventUploadDocumentSuccessfullyCalled)
        XCTAssertTrue(mockView.showSuccessMessageCalled)
    }

    func test_didFailToUploadDocument_behaviour() {
        // Given
        // When
        presenter.didFailToUploadDocument()

        // Then
        XCTAssertTrue(mockView.hideLoadingCalled)
        XCTAssertTrue(mockInteractor.sendEventFailToUploadDocumentCalled)
        XCTAssertTrue(mockView.showErrorMessageCalled)
    }

    func test_didRetrieveSelection_updatesView() {
        // Given
        let dummyCountry = CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "br")
        let dummyDocument = DocumentSelectionEntity.UserEntity(name: "CNH", iconName: "car.fill")
        let dummyBirthDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!

        let response = UserSelectionEntity.Response(selection: .init(
            country: dummyCountry,
            document: dummyDocument,
            birthDate: dummyBirthDate
        ))

        // When
        presenter.didRetrieveSelection(response)

        // Then
        XCTAssertEqual(mockView.displayedCountryName, "Brasil")
        XCTAssertEqual(mockView.displayedDocumentName, "CNH")
        XCTAssertTrue(mockView.displayBirthDateFormattedCalled)
    }

    func test_didConfirmSuccess_callsRouterRestartFlow() {
        // Given
        // When
        presenter.didConfirmSuccess()

        // Then
        XCTAssertTrue(mockRouter.restartFlowCalled)
    }

    func test_didTapCapture_whenImageExists_shouldShowCapturedImage() {
        // Given
        let document = DocumentSelectionEntity.UserEntity(name: "CNH", iconName: "car.fill")
        presenter.document = document

        // When
        presenter.didTapCapture()

        // Then
        XCTAssertTrue(mockView.showCapturedImageCalled)
    }
}

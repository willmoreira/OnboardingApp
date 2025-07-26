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
        let country = CountrySelectionEntity(name: "Brasil", flagImageName: "br")
        let document = DocumentSelectionUserEntity(name: "CNH", iconName: "car.fill")

        // When
        presenter.didRetrieveSelection(country: country, document: document)

        // Then
        XCTAssertEqual(mockView.displayedCountryName, "Brasil")
        XCTAssertEqual(mockView.displayedDocumentName, "CNH")
    }
}

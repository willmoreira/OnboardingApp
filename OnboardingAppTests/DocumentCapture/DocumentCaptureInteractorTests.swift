import XCTest
@testable import OnboardingApp

final class DocumentCaptureInteractorTests: XCTestCase {

    private var interactor: DocumentCaptureInteractor!
    private var mockPresenter: DocumentCapturePresenterMock!
    private var mockUploadService: UploadServiceMock!
    private var mockLogger: EventLoggerMock!

    override func setUp() {
        super.setUp()
        mockPresenter = DocumentCapturePresenterMock()
        mockUploadService = UploadServiceMock()
        mockLogger = EventLoggerMock()
        interactor = DocumentCaptureInteractor(uploadService: mockUploadService, eventLogger: mockLogger)
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockUploadService = nil
        mockLogger = nil
        super.tearDown()
    }

    func test_uploadDocument_success_callsDidUploadDocumentSuccessfully() {
        // Given
        mockUploadService.result = .success(())

        // When
        interactor.uploadDocument(UIImage())

        // Then
        XCTAssertTrue(mockLogger.loggedEvents.contains { $0.event == "send_document" })
        XCTAssertTrue(mockPresenter.didUploadSuccessfullyCalled)
    }

    func test_uploadDocument_failure_callsDidFailToUploadDocument() {
        // Given
        mockUploadService.result = .failure(NSError(domain: "test", code: 1))

        // When
        interactor.uploadDocument(UIImage())

        // Then
        XCTAssertTrue(mockPresenter.didFailToUploadCalled)
    }

    func test_fetchSavedSelection_callsPresenterWithValidData() {
        // Given
        let mockCountry = CountrySelectionEntity(name: "Brasil", flagImageName: "br")
        let mockDocument = DocumentSelectionUserEntity(name: "CNH", iconName: "car.fill")
        UserDefaults.standard.setEncodable(mockCountry, forKey: "selectedCountry")
        UserDefaults.standard.setEncodable(mockDocument, forKey: "selectedDocument")

        // When
        interactor.fetchSavedSelection()

        // Then
        XCTAssertEqual(mockPresenter.retrievedCountry?.name, "Brasil")
        XCTAssertEqual(mockPresenter.retrievedDocument?.name, "CNH")
    }

    func test_sendEventUploadDocumentSuccessfully_logsCorrectEvent() {
        // Given
        // When
        interactor.sendEventUploadDocumentSuccessfully()

        // Then
        XCTAssertTrue(mockLogger.loggedEvents.contains { $0.event == "upload_document_successfully" })
    }

    func test_sendEventFailToUploadDocument_logsCorrectEvent() {
        // Given
        // When
        interactor.sendEventFailToUploadDocument()

        // Then
        XCTAssertTrue(mockLogger.loggedEvents.contains { $0.event == "fail_to_upload_document" })
    }
}

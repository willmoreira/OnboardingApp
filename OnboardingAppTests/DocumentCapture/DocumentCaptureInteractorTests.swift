import XCTest
@testable import OnboardingApp
import CoreKit

final class DocumentCaptureInteractorTests: XCTestCase {

    private var interactor: DocumentCaptureInteractor!
    private var mockPresenter: MockDocumentCapturePresenter!
    private var mockUploadService: MockUploadService!
    private var mockLogger: MockEventLogger!

    override func setUp() {
        super.setUp()
        mockPresenter = MockDocumentCapturePresenter()
        mockUploadService = MockUploadService()
        mockLogger = MockEventLogger()
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
        mockUploadService.result = .success(())

        interactor.uploadDocument(UIImage())

        XCTAssertTrue(mockLogger.loggedEvents.contains { $0.event == "send_document" })
        XCTAssertTrue(mockPresenter.didUploadSuccessfullyCalled)
    }

    func test_uploadDocument_failure_callsDidFailToUploadDocument() {
        mockUploadService.result = .failure(NSError(domain: "test", code: 1))

        interactor.uploadDocument(UIImage())

        XCTAssertTrue(mockPresenter.didFailToUploadCalled)
    }

    func test_fetchSavedSelection_callsPresenterWithValidData() {
        let mockCountry = Country(name: "Brasil", flagImageName: "br")
        let mockDocument = Document(name: "CNH", iconName: "car.fill")
        UserDefaults.standard.setEncodable(mockCountry, forKey: "selectedCountry")
        UserDefaults.standard.setEncodable(mockDocument, forKey: "selectedDocument")

        interactor.fetchSavedSelection()

        XCTAssertEqual(mockPresenter.retrievedCountry?.name, "Brasil")
        XCTAssertEqual(mockPresenter.retrievedDocument?.name, "CNH")
    }

    func test_sendEventUploadDocumentSuccessfully_logsCorrectEvent() {
        interactor.sendEventUploadDocumentSuccessfully()
        XCTAssertTrue(mockLogger.loggedEvents.contains { $0.event == "upload_document_successfully" })
    }

    func test_sendEventFailToUploadDocument_logsCorrectEvent() {
        interactor.sendEventFailToUploadDocument()
        XCTAssertTrue(mockLogger.loggedEvents.contains { $0.event == "fail_to_upload_document" })
    }
}

import XCTest
@testable import OnboardingApp

final class DocumentCaptureInteractorTests: XCTestCase {

    private var interactor: DocumentCaptureInteractor!
    private var mockPresenter: DocumentCapturePresenterMock!
    private var mockUploadService: UploadServiceMock!
    private var mockLogger: EventLoggerMock!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "selectedCountry")
        UserDefaults.standard.removeObject(forKey: "selectedDocument")

        mockPresenter = DocumentCapturePresenterMock()
        mockUploadService = UploadServiceMock()
        mockLogger = EventLoggerMock()
        interactor = DocumentCaptureInteractor(uploadService: mockUploadService, eventLogger: mockLogger)
        interactor.presenter = mockPresenter

        let country = CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "br")
        let document = DocumentSelectionEntity.UserEntity(name: "CNH", iconName: "car.fill")
        let birthDate = Calendar.current.date(byAdding: .year, value: -30, to: Date())

        UserDefaults.standard.setEncodable(birthDate, forKey: "birthDate")
        UserDefaults.standard.setEncodable(country, forKey: "selectedCountry")
        UserDefaults.standard.setEncodable(document, forKey: "selectedDocument")
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
        // When
        interactor.fetchSavedSelection()

        // Then
        // No mockPresenter você precisa ter propriedades para capturar o que foi recebido
        XCTAssertEqual(mockPresenter.retrievedSelection?.country.name, "Brasil")
        XCTAssertEqual(mockPresenter.retrievedSelection?.document.name, "CNH")
        // Data de nascimento pode ser testada se quiser, ou ignorada
    }

    func test_sendEventUploadDocumentSuccessfully_logsCorrectEvent() {
        // When
        interactor.sendEventUploadDocumentSuccessfully()

        // Then
        XCTAssertTrue(mockLogger.loggedEvents.contains { $0.event == "upload_document_successfully" })
    }

    func test_sendEventFailToUploadDocument_logsCorrectEvent() {
        // When
        interactor.sendEventFailToUploadDocument()

        // Then
        XCTAssertTrue(mockLogger.loggedEvents.contains { $0.event == "fail_to_upload_document" })
    }
}

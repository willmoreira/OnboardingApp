import XCTest
@testable import OnboardingApp

final class DocumentCaptureInteractorTests: XCTestCase {

    private var interactor: DocumentCaptureInteractor!
    private var mockPresenter: DocumentCapturePresenterMock!
    private var mockUploadService: UploadServiceMock!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "selectedCountry")
        UserDefaults.standard.removeObject(forKey: "selectedDocument")
        UserDefaults.standard.removeObject(forKey: "birthDate")

        mockPresenter = DocumentCapturePresenterMock()
        mockUploadService = UploadServiceMock()
        interactor = DocumentCaptureInteractor(uploadService: mockUploadService)
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
        super.tearDown()
    }

    func test_uploadDocument_success_callsDidUploadDocumentSuccessfully() {
        // Given
        mockUploadService.result = .success(())

        // When
        interactor.uploadDocument(UIImage())

        // Then
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
        XCTAssertEqual(mockPresenter.retrievedSelection?.country.name, "Brasil")
        XCTAssertEqual(mockPresenter.retrievedSelection?.document.name, "CNH")
    }
}

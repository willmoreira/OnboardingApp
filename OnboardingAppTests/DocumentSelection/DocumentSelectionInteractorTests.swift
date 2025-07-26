import XCTest
@testable import OnboardingApp
import UIKit

final class DocumentSelectionInteractorTests: XCTestCase {

    private var mockPresenter: DocumentSelectionPresenterMock!
    private var mockLogger: EventLoggerMock!
    private var interactor: DocumentSelectionInteractor!

    override func setUp() {
        super.setUp()
        mockPresenter = DocumentSelectionPresenterMock()
        mockLogger = EventLoggerMock()
        let country = CountrySelectionEntity(name: "Brasil", flagImageName: "br")
        interactor = DocumentSelectionInteractor(country: country, eventLogger: mockLogger)
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        mockPresenter = nil
        mockLogger = nil
        interactor = nil
        super.tearDown()
    }

    func test_fetchDocuments_forBrazil_returnsCorrectDocs() {
        // Given

        // When
        interactor.fetchDocuments()

        // Then
        XCTAssertEqual(mockPresenter.receivedDocuments.count, 2)
        XCTAssertEqual(mockPresenter.receivedDocuments.first?.name, "RG")
        XCTAssertEqual(mockPresenter.receivedCountry?.name, "Brasil")
    }

    func test_sendEvent_logsCorrectEvent() {
        // Given
        let document = DocumentSelectionUserEntity(name: "CNH", iconName: "car.fill")
        let country = CountrySelectionEntity(name: "Brasil", flagImageName: "br")

        // When
        interactor.sendEvent(country: country, document: document)

        // Then
        XCTAssertEqual(mockLogger.loggedEvents.count, 1)
        let logged = mockLogger.loggedEvents.last
        XCTAssertEqual(logged?.event, "tapped_select_document")
        XCTAssertEqual(logged?.parameters?["document"] as? String, "CNH")
    }

    func test_saveSelectedCountryAndDocument_savesCorrectlyToUserDefaults() {
        // Given
        let country = CountrySelectionEntity(name: "Estados Unidos", flagImageName: "us")
        let document = DocumentSelectionUserEntity(name: "Passport", iconName: "globe.americas.fill")
        let countryKey = "selectedCountry"
        let documentKey = "selectedDocument"
        UserDefaults.standard.removeObject(forKey: countryKey)
        UserDefaults.standard.removeObject(forKey: documentKey)

        // When
        interactor.saveSelectedCountryAndDocument(country: country, document: document)

        // Then
        let savedCountry = UserDefaults.standard.getDecodable(forKey: countryKey, as: CountrySelectionEntity.self)
        let savedDocument = UserDefaults.standard.getDecodable(forKey: documentKey, as: DocumentSelectionUserEntity.self)

        XCTAssertEqual(savedCountry?.name, "Estados Unidos")
        XCTAssertEqual(savedCountry?.flagImageName, "us")
        XCTAssertEqual(savedDocument?.name, "Passport")
        XCTAssertEqual(savedDocument?.iconName, "globe.americas.fill")
    }

    func test_fetchDocuments_forUnitedStates_returnsCorrectDocs() {
        // Given
        let country = CountrySelectionEntity(name: "Estados Unidos", flagImageName: "us")
        interactor = DocumentSelectionInteractor(country: country, eventLogger: mockLogger)
        interactor.presenter = mockPresenter

        // When
        interactor.fetchDocuments()

        // Then
        XCTAssertEqual(mockPresenter.receivedDocuments.count, 2)
        XCTAssertEqual(mockPresenter.receivedDocuments[0].name, "Driver License")
        XCTAssertEqual(mockPresenter.receivedDocuments[1].name, "Passport")
    }

    func test_fetchDocuments_forUnknownCountry_returnsDefaultDocs() {
        // Given
        let country = CountrySelectionEntity(name: "Canadá", flagImageName: "ca")
        interactor = DocumentSelectionInteractor(country: country, eventLogger: mockLogger)
        interactor.presenter = mockPresenter

        // When
        interactor.fetchDocuments()

        // Then
        XCTAssertEqual(mockPresenter.receivedDocuments.count, 1)
        XCTAssertEqual(mockPresenter.receivedDocuments[0].name, "Passport")
    }
}

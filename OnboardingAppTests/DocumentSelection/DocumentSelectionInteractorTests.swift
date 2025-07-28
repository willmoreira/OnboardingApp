import XCTest
@testable import OnboardingApp
import UIKit

final class DocumentSelectionInteractorTests: XCTestCase {

    private var mockPresenter: DocumentSelectionPresenterMock!
    private var mockLogger: EventLoggerMock!
    private var interactor: DocumentSelectionInteractor!
    private let brazilCountry = CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "br")

    override func setUp() {
        super.setUp()
        mockPresenter = DocumentSelectionPresenterMock()
        mockLogger = EventLoggerMock()
        interactor = DocumentSelectionInteractor(country: brazilCountry)
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        mockPresenter = nil
        mockLogger = nil
        interactor = nil
        super.tearDown()
    }

    func test_fetchDocuments_callsPresenterWithCorrectResponse() {
        // When
        interactor.fetchDocuments()

        // Then
        XCTAssertFalse(mockPresenter.receivedDocuments.isEmpty)
        XCTAssertEqual(interactor.country.name, "Brasil")
    }

    func test_saveSelectedCountryAndDocument_savesToUserDefaults() {
        // Given
        let document = DocumentSelectionEntity.UserEntity(name: "Passport", iconName: "globe.americas.fill")
        let request = DocumentSelectionEntity.Request(entity: document)
        let countryKey = "selectedCountry"
        let documentKey = "selectedDocument"
        UserDefaults.standard.removeObject(forKey: countryKey)
        UserDefaults.standard.removeObject(forKey: documentKey)

        // When
        interactor.saveSelectedCountryAndDocument(request: request)

        // Then
        let savedDocument = UserDefaults.standard.getDecodable(forKey: documentKey, as: DocumentSelectionEntity.UserEntity.self)

        XCTAssertEqual(savedDocument?.name, "Passport")
    }

    func test_fetchDocuments_forUnitedStates_returnsCorrectDocuments() {
        // Given
        let usaCountry = CountrySelectionEntity.UserEntity(name: "Estados Unidos", flagImageName: "us")
        let interactor = DocumentSelectionInteractor(country: usaCountry)
        interactor.presenter = mockPresenter

        // When
        interactor.fetchDocuments()

        // Then
        XCTAssertEqual(mockPresenter.receivedDocuments.count, 2)
        XCTAssertEqual(mockPresenter.receivedDocuments[0].name, "Driver License")
        XCTAssertEqual(mockPresenter.receivedDocuments[1].name, "Passport")
    }

    func test_fetchDocuments_forOtherCountry_returnsPassportOnly() {
        // Given
        let germany = CountrySelectionEntity.UserEntity(name: "Alemanha", flagImageName: "de")
        let interactor = DocumentSelectionInteractor(country: germany)
        interactor.presenter = mockPresenter

        // When
        interactor.fetchDocuments()

        // Then
        XCTAssertEqual(mockPresenter.receivedDocuments.count, 1)
        XCTAssertEqual(mockPresenter.receivedDocuments[0].name, "Passport")
    }
}

import XCTest
@testable import OnboardingApp

final class CountrySelectionInteractorTests: XCTestCase {

    private var mockPresenter: CountrySelectionPresenterMock!
    private var mockLogger: EventLoggerMock!
    private var interactor: CountrySelectionInteractor!

    override func setUp() {
        super.setUp()
        mockPresenter = CountrySelectionPresenterMock()
        mockLogger = EventLoggerMock()
        interactor = CountrySelectionInteractor(eventLogger: mockLogger)
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        mockPresenter = nil
        mockLogger = nil
        interactor = nil
        super.tearDown()
    }

    func test_fetchCountries_returnsMockList() {
        // Given: Crie um Request com um país default, se for necessário pelo seu método
        let request = CountrySelectionEntity.Request(entity: CountrySelectionEntity.UserEntity(name: "", flagImageName: ""))

        // When
        interactor.fetchCountries(request: request)

        // Then
        XCTAssertFalse(mockPresenter.fetchedCountries.isEmpty, "Esperava países retornados")
        XCTAssertEqual(mockPresenter.fetchedCountries.first?.name, "Brasil")
    }

    func test_sendEventTap_logsCorrectEvent() {
        // Given
        let countryEntity = CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "br")
        let request = CountrySelectionEntity.Request(entity: countryEntity)

        // When
        interactor.sendEventTap(with: request)

        // Then
        XCTAssertEqual(mockLogger.loggedEvents.count, 1)
        XCTAssertEqual(mockLogger.loggedEvents.first?.event, "tapped_select_country")
        XCTAssertEqual(mockLogger.loggedEvents.first?.parameters?["country"] as? String, "Brasil")
    }
}

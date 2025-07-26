import XCTest
@testable import OnboardingApp

final class CountrySelectionInteractorTests: XCTestCase {

    private var mockPresenter: MockCountrySelectionPresenter!
    private var mockLogger: MockEventLogger!
    private var interactor: CountrySelectionInteractor!

    override func setUp() {
        super.setUp()
        mockPresenter = MockCountrySelectionPresenter()
        mockLogger = MockEventLogger()
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
        // When
        interactor.fetchCountries()

        // Then
        XCTAssertEqual(mockPresenter.fetchedCountries.count, 5)
        XCTAssertEqual(mockPresenter.fetchedCountries[0].name, "Brasil")
    }

    func test_sendEventTap_logsCorrectEvent() {
        // Given
        let country = CountrySelectionEntity(name: "Brasil", flagImageName: "br")

        // When
        interactor.sendEventTap(with: country)

        // Then
        XCTAssertEqual(mockLogger.loggedEvents.count, 1)
        XCTAssertEqual(mockLogger.loggedEvents.first?.event, "tapped_select_country")
        XCTAssertEqual(mockLogger.loggedEvents.first?.parameters?["country"] as? String, "Brasil")
    }
}

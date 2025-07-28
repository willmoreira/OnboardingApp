import XCTest
@testable import OnboardingApp

final class CountrySelectionPresenterTests: XCTestCase {

    private var mockView: CountrySelectionViewMock!
    private var mockInteractor: CountrySelectionInteractorMock!
    private var mockRouter: CountrySelectionRouterMock!
    private var presenter: CountrySelectionPresenter!
    private var mockLogger: EventLoggerMock!

    override func setUp() {
        super.setUp()
        mockView = CountrySelectionViewMock()
        mockInteractor = CountrySelectionInteractorMock()
        mockRouter = CountrySelectionRouterMock()
        mockLogger = EventLoggerMock()
        presenter = CountrySelectionPresenter(
            view: mockView,
            interactor: mockInteractor,
            router: mockRouter,
            eventLogger: mockLogger
        )
    }

    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        presenter = nil
        mockLogger = nil
        super.tearDown()
    }

    func test_viewDidLoad_callsFetchCountries() {
        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(mockInteractor.fetchCountriesCalled)
    }

    func test_didFetchCountries_showsCountriesOnView() {
        // Given
        let mockCountries = [
            CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "br")
        ]
        let response = CountrySelectionEntity.Response(countries: mockCountries)

        // When
        presenter.didFetchCountries(response)

        // Then
        XCTAssertEqual(mockView.shownCountries, mockCountries)
    }

    func test_didTapNext_navigates() {
        // Given
        let country = CountrySelectionEntity.UserEntity(name: "Japão", flagImageName: "jp")
        let request = CountrySelectionEntity.Request(entity: country)

        // When
        presenter.didTapNext(with: request)

        // Then
        XCTAssertTrue(mockRouter.navigatedToDocumentSelection)
        XCTAssertEqual(mockRouter.selectedCountry, country)
    }
}

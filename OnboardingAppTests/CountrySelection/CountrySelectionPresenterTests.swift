import XCTest
@testable import OnboardingApp

final class CountrySelectionPresenterTests: XCTestCase {

    private var mockView: MockCountrySelectionView!
    private var mockInteractor: MockCountrySelectionInteractor!
    private var mockRouter: MockCountrySelectionRouter!
    private var presenter: CountrySelectionPresenter!

    override func setUp() {
        super.setUp()
        mockView = MockCountrySelectionView()
        mockInteractor = MockCountrySelectionInteractor()
        mockRouter = MockCountrySelectionRouter()
        presenter = CountrySelectionPresenter(view: mockView,
                                              interactor: mockInteractor,
                                              router: mockRouter)
    }

    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        presenter = nil
        super.tearDown()
    }

    func test_viewDidLoad_callsFetchCountries() {
        // Given
        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(mockInteractor.fetchCountriesCalled)
    }

    func test_didFetchCountries_showsCountriesOnView() {
        // Given
        let mockCountries = [CountrySelectionEntity(name: "Brasil", flagImageName: "br")]

        // When
        presenter.didFetchCountries(mockCountries)

        // Then
        XCTAssertEqual(mockView.shownCountries, mockCountries)
    }

    func test_didTapNext_sendsEvent_and_navigates() {
        // Given
        let country = CountrySelectionEntity(name: "Japão", flagImageName: "jp")

        // When
        presenter.didTapNext(with: country)

        // Then
        XCTAssertTrue(mockInteractor.sendEventCalled)
        XCTAssertEqual(mockInteractor.sentCountry, country)

        XCTAssertTrue(mockRouter.navigatedToDocumentSelection)
        XCTAssertEqual(mockRouter.selectedCountry, country)
    }
}


import XCTest
@testable import OnboardingApp
import CoreKit

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
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchCountriesCalled)
    }

    func test_didFetchCountries_showsCountriesOnView() {
        let mockCountries = [Country(name: "Brasil", flagImageName: "br")]
        presenter.didFetchCountries(mockCountries)
        XCTAssertEqual(mockView.shownCountries, mockCountries)
    }

    func test_didTapNext_sendsEvent_and_navigates() {
        let country = Country(name: "Japão", flagImageName: "jp")
        presenter.didTapNext(with: country)

        XCTAssertTrue(mockInteractor.sendEventCalled)
        XCTAssertEqual(mockInteractor.sentCountry, country)

        XCTAssertTrue(mockRouter.navigatedToDocumentSelection)
        XCTAssertEqual(mockRouter.selectedCountry, country)
    }
}

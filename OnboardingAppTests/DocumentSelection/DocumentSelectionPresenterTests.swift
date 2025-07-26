import XCTest
@testable import OnboardingApp

final class DocumentSelectionPresenterTests: XCTestCase {

    private var mockView: MockDocumentSelectionView!
    private var mockInteractor: MockDocumentSelectionInteractor!
    private var mockRouter: MockDocumentSelectionRouter!
    private var presenter: DocumentSelectionPresenter!

    override func setUp() {
        super.setUp()
        mockView = MockDocumentSelectionView()
        mockInteractor = MockDocumentSelectionInteractor()
        mockRouter = MockDocumentSelectionRouter()
        presenter = DocumentSelectionPresenter(view: mockView,
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

    func test_viewDidLoad_callsFetchDocuments() {
        // Given
        // (Presenter configurado no setUp)

        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(mockInteractor.fetchDocumentsCalled)
    }

    func test_didFetchDocuments_updatesCountry_and_showsDocuments() {
        // Given
        let docs = [DocumentSelectionUserEntity(name: "RG", iconName: "person.text.rectangle")]
        let country = CountrySelectionEntity(name: "Brasil", flagImageName: "br")

        // When
        presenter.didFetchDocuments(docs, country)

        // Then
        XCTAssertEqual(mockView.shownDocuments, docs)
    }

    func test_didTapNext_callsSaveSendEventAndNavigate() {
        // Given
        let docs = [DocumentSelectionUserEntity(name: "CNH", iconName: "car.fill")]
        let country = CountrySelectionEntity(name: "Brasil", flagImageName: "br")
        presenter.didFetchDocuments(docs, country)

        // When
        presenter.didTapNext(with: docs[0])

        // Then
        XCTAssertEqual(mockInteractor.savedCountry?.name, "Brasil")
        XCTAssertEqual(mockInteractor.savedDocument?.name, "CNH")
        XCTAssertTrue(mockInteractor.sendEventCalled)
        XCTAssertEqual(mockRouter.navigated, true)
    }
}

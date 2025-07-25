import XCTest
@testable import OnboardingApp
import CoreKit

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
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchDocumentsCalled)
    }

    func test_didFetchDocuments_updatesCountry_and_showsDocuments() {
        let docs = [Document(name: "RG", iconName: "person.text.rectangle")]
        let country = Country(name: "Brasil", flagImageName: "br")

        presenter.didFetchDocuments(docs, country)

        XCTAssertEqual(mockView.shownDocuments, docs)
    }

    func test_didTapNext_callsSaveSendEventAndNavigate() {
        let docs = [Document(name: "CNH", iconName: "car.fill")]
        let country = Country(name: "Brasil", flagImageName: "br")
        presenter.didFetchDocuments(docs, country)

        presenter.didTapNext(with: docs[0])

        XCTAssertEqual(mockView.savedCountry?.name, "Brasil")
        XCTAssertEqual(mockView.savedDocument?.name, "CNH")
        XCTAssertTrue(mockInteractor.sendEventCalled)
        XCTAssertEqual(mockRouter.navigated, true)
    }
}


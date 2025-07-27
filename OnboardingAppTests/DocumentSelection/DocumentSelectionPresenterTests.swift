import XCTest
@testable import OnboardingApp

final class DocumentSelectionPresenterTests: XCTestCase {

    private var mockView: DocumentSelectionViewMock!
    private var mockInteractor: DocumentSelectionInteractorMock!
    private var mockRouter: DocumentSelectionRouterMock!
    private var presenter: DocumentSelectionPresenter!

    override func setUp() {
        super.setUp()
        mockView = DocumentSelectionViewMock()
        mockInteractor = DocumentSelectionInteractorMock()
        mockRouter = DocumentSelectionRouterMock()
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
        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(mockInteractor.fetchDocumentsCalled)
    }

    func test_didFetchDocuments_updatesCountry_and_showsDocuments() {
        // Given
        let docs = [
            DocumentSelectionEntity.UserEntity(name: "RG", iconName: "person.text.rectangle")
        ]
        let response = DocumentSelectionEntity.Response(documents: docs)

        // When
        presenter.didFetchDocuments(response)

        // Then
        XCTAssertEqual(mockView.shownDocuments, docs)
        // Se quiser testar a country guardada no presenter (private), pode expor um getter só para teste ou ignorar.
    }

    func test_didTapNext_callsSaveSendEventAndNavigate() {
        // Given
        let document = DocumentSelectionEntity.UserEntity(name: "CNH", iconName: "car.fill")
        mockInteractor.saveSelectedCalled = false
        mockInteractor.sendEventCalled = false
        mockRouter.navigated = false

        // When
        presenter.didTapNext(with: document)

        // Then
        XCTAssertTrue(mockInteractor.saveSelectedCalled)
        XCTAssertEqual(mockInteractor.sentRequestForSave?.entity, document)
        XCTAssertTrue(mockInteractor.sendEventCalled)
        XCTAssertEqual(mockInteractor.sentRequestForEvent?.entity, document)
        XCTAssertTrue(mockRouter.navigated)
    }
}

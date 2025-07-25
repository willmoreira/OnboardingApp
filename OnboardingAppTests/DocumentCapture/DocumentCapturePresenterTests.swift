import XCTest
@testable import OnboardingApp
import CoreKit

final class DocumentCapturePresenterTests: XCTestCase {

    private var presenter: DocumentCapturePresenter!
    private var mockView: MockDocumentCaptureView!
    private var mockInteractor: MockDocumentCaptureInteractor!
    private var mockRouter: MockDocumentCaptureRouter!

    override func setUp() {
        super.setUp()
        mockView = MockDocumentCaptureView()
        mockInteractor = MockDocumentCaptureInteractor()
        mockRouter = MockDocumentCaptureRouter()
        presenter = DocumentCapturePresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func test_viewDidLoad_callsFetchSavedSelection() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchSavedSelectionCalled)
    }

    func test_didTapSend_withoutImage_showsError() {
        presenter.didTapSend()
        XCTAssertTrue(mockView.showErrorMessageCalled)
    }

    func test_didTapSend_withImage_uploadsDocument() {
        presenter.didTapCapture()
        presenter.didTapSend()
        
        XCTAssertTrue(mockView.showLoadingCalled)
        XCTAssertTrue(mockInteractor.uploadDocumentCalled)
    }

    func test_didUploadDocumentSuccessfully_behaviour() {
        presenter.didUploadDocumentSuccessfully()
        XCTAssertTrue(mockView.hideLoadingCalled)
        XCTAssertTrue(mockInteractor.sendEventUploadDocumentSuccessfullyCalled)
        XCTAssertTrue(mockView.showSuccessMessageCalled)
    }

    func test_didFailToUploadDocument_behaviour() {
        presenter.didFailToUploadDocument()
        XCTAssertTrue(mockView.hideLoadingCalled)
        XCTAssertTrue(mockInteractor.sendEventFailToUploadDocumentCalled)
        XCTAssertTrue(mockView.showErrorMessageCalled)
    }

    func test_didRetrieveSelection_updatesView() {
        let country = Country(name: "Brasil", flagImageName: "br")
        let document = Document(name: "CNH", iconName: "car.fill")

        presenter.didRetrieveSelection(country: country, document: document)

        XCTAssertEqual(mockView.displayedCountryName, "Brasil")
        XCTAssertEqual(mockView.displayedDocumentName, "CNH")
    }
}


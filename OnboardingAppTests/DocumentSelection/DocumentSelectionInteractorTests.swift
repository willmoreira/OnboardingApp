import XCTest
@testable import OnboardingApp
import CoreKit

final class DocumentSelectionInteractorTests: XCTestCase {

    private var mockPresenter: MockDocumentSelectionPresenter!
    private var mockLogger: MockEventLogger!
    private var interactor: DocumentSelectionInteractor!

    override func setUp() {
        super.setUp()
        mockPresenter = MockDocumentSelectionPresenter()
        mockLogger = MockEventLogger()
        let country = Country(name: "Brasil", flagImageName: "br")
        interactor = DocumentSelectionInteractor(country: country, eventLogger: mockLogger)
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        mockPresenter = nil
        mockLogger = nil
        interactor = nil
        super.tearDown()
    }

    func test_fetchDocuments_forBrazil_returnsCorrectDocs() {
        interactor.fetchDocuments()

        XCTAssertEqual(mockPresenter.receivedDocuments.count, 2)
        XCTAssertEqual(mockPresenter.receivedDocuments.first?.name, "RG")
        XCTAssertEqual(mockPresenter.receivedCountry?.name, "Brasil")
    }

    func test_sendEvent_logsCorrectEvent() {
        let document = Document(name: "CNH", iconName: "car.fill")
        let country = Country(name: "Brasil", flagImageName: "br")
        interactor.sendEvent(country: country, document: document)

        XCTAssertEqual(mockLogger.loggedEvents.count, 1)

        let logged = mockLogger.loggedEvents.last
        XCTAssertEqual(logged?.event, "tapped_select_document")
        XCTAssertEqual(logged?.parameters?["document"] as? String, "CNH")
    }
}


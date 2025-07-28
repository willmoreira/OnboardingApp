import XCTest

final class DocumentSelectionViewControllerUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-UITestDocumentSelection")
        app.launch()
    }

    func testDocumentSelectionAndNextButton() {
        let app = XCUIApplication()

        let cell = app.tables.cells.staticTexts["RG"]
        XCTAssertTrue(cell.exists)
        cell.tap()

        let nextButton = app.buttons["Botão Avançar"]
        XCTAssertTrue(nextButton.isEnabled)
        nextButton.tap()
    }
}

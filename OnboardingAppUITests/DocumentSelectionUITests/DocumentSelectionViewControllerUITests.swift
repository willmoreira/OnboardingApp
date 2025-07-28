import XCTest

final class DocumentSelectionViewControllerUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
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

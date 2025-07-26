import XCTest

final class CountrySelectionViewControllerUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITestMode"]
        app.launch()
    }

    func testSelectCountryAndTapNext() {
        let table = app.tables.element
        XCTAssertTrue(table.waitForExistence(timeout: 5))

        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()

        let nextButton = app.buttons["Avançar"]
        XCTAssertTrue(nextButton.waitForExistence(timeout: 2))
        XCTAssertTrue(nextButton.isEnabled)
        nextButton.tap()
    }
}

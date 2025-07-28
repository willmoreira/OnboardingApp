import XCTest

final class BirthDateViewControllerUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITestBirthDate"]
        app.launch()
    }

    func testSelectValidBirthDateAndContinue() {
        let app = XCUIApplication()
        app.launchArguments.append("-UITestBirthDate")
        app.launch()

        let picker = app.datePickers["birthDatePickerIdentifier"]
        XCTAssertTrue(picker.waitForExistence(timeout: 2))

        let dayWheel = picker.pickerWheels.element(boundBy: 0)
        let monthWheel = picker.pickerWheels.element(boundBy: 1)
        let yearWheel = picker.pickerWheels.element(boundBy: 2)

        XCTAssertGreaterThanOrEqual(picker.pickerWheels.count, 3, "Deve haver pelo menos 3 picker wheels")

        dayWheel.adjust(toPickerWheelValue: "1")
        monthWheel.adjust(toPickerWheelValue: "abril")
        yearWheel.adjust(toPickerWheelValue: "2000")

        let nextButton = app.buttons["Avançar"]
        XCTAssertTrue(nextButton.waitForExistence(timeout: 1))
        XCTAssertTrue(nextButton.isEnabled)
        nextButton.tap()
    }
}

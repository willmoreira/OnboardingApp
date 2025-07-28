import XCTest

final class DocumentCaptureViewControllerUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-UITestDocumentCapture")
        app.launch()
    }

    func testCaptureImageFlow() {
        let app = XCUIApplication()

        let captureButton = app.buttons["captureButton"]
        XCTAssertTrue(captureButton.waitForExistence(timeout: 5))
        captureButton.tap()

        let image = app.images["capturedImage"]
        XCTAssertTrue(image.waitForExistence(timeout: 5))
    }
}

import XCTest

final class DocumentCaptureViewControllerUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("-UITestDocumentCapture")
        app.launch()
    }

    func testCaptureImageFlow() {
        let app = XCUIApplication()

        let captureButton = app.buttons["captureButton"]
        XCTAssertTrue(captureButton.waitForExistence(timeout: 5))  // Aguarda botão aparecer
        captureButton.tap()

        let image = app.images["capturedImage"]
        XCTAssertTrue(image.waitForExistence(timeout: 5))  // Aguarda imagem aparecer
    }
}

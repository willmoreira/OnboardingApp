import XCTest
@testable import OnboardingApp

final class CountrySelectionInteractorTests: XCTestCase {

    private var mockPresenter: CountrySelectionPresenterMock!
    private var interactor: CountrySelectionInteractor!

    override func setUp() {
        super.setUp()
        mockPresenter = CountrySelectionPresenterMock()
        interactor = CountrySelectionInteractor()
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        mockPresenter = nil
        interactor = nil
        super.tearDown()
    }

    func test_fetchCountries_returnsMockList() {
        // Given
        let request = CountrySelectionEntity.Request(entity: CountrySelectionEntity.UserEntity(name: "", flagImageName: ""))

        // When
        interactor.fetchCountries(request: request)

        // Then
        XCTAssertFalse(mockPresenter.fetchedCountries.isEmpty, "Esperava países retornados")
        XCTAssertEqual(mockPresenter.fetchedCountries.first?.name, "Brasil")
    }
}

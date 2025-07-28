import Foundation
@testable import OnboardingApp

final class DocumentSelectionPresenterMock: DocumentSelectionInteractorOutputProtocol {

    private(set) var receivedResponse: DocumentSelectionEntity.Response?
    private(set) var receivedDocuments: [DocumentSelectionEntity.UserEntity] = []

    func didFetchDocuments(_ response: DocumentSelectionEntity.Response) {
        receivedResponse = response
        receivedDocuments = response.documents
    }
}

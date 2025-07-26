import Foundation
@testable import OnboardingApp

final class DocumentSelectionPresenterMock: DocumentSelectionInteractorOutputProtocol {

    var receivedResponse: DocumentSelectionEntity.Response?
    var receivedDocuments: [DocumentSelectionEntity.UserEntity] = []

    func didFetchDocuments(_ response: DocumentSelectionEntity.Response) {
        receivedResponse = response
        receivedDocuments = response.documents
    }
}

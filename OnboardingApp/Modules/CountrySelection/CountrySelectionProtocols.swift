import UIKit

protocol CountrySelectionViewProtocol: AnyObject {
    func showCountries(_ countries: [Country])
}

protocol CountrySelectionInteractorProtocol: AnyObject {
    func fetchCountries()
}

protocol CountrySelectionPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didFetchCountries(_ countries: [Country])
    func didTapNext(with country: Country)
}

protocol CountrySelectionInteractorOutputProtocol: AnyObject {
    
}

protocol CountrySelectionRouterProtocol: AnyObject {
    func navigateToNextStep(with country: Country)
}

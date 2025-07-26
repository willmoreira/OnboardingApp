import Foundation

final class CountrySelectionPresenterUITestMock: CountrySelectionPresenterProtocol {

    weak var view: CountrySelectionViewProtocol?

    func viewDidLoad() {
        let mockCountries = [
            CountrySelectionEntity.UserEntity(name: "Brasil", flagImageName: "br"),
            CountrySelectionEntity.UserEntity(name: "Estados Unidos", flagImageName: "us")
        ]
        
        // Monta o ViewModel com os UserEntity mockados
        let viewModel = CountrySelectionEntity.ViewModel(countries: mockCountries)
        
        // Passa para a view o ViewModel correto
        view?.showCountries(viewModel)
    }

    func didTapNext(with request: CountrySelectionEntity.Request) {
        UserDefaults.standard.set(true, forKey: "didNavigate")
        UserDefaults.standard.set(request.entity.name, forKey: "selectedCountry")
    }
}

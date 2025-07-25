import UIKit

final class CountrySelectionViewController: UIViewController {
    var presenter: CountrySelectionPresenterProtocol!
    
    private var countries: [Country] = []
    private var selectedCountry: Country?
    private var selectedIndexPath: IndexPath?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Avançar", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    @objc private func nextButtonTapped() {
        guard let country = selectedCountry else { return }
        presenter.didTapNext(with: country)
    }
    
    private func setupUI() {
        title = "Selecione o País"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),

            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension CountrySelectionViewController: CountrySelectionViewProtocol {
    func showCountries(_ countries: [Country]) {
        self.countries = countries
        tableView.reloadData()
    }
}

extension CountrySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = country.name
        content.image = UIImage(named: country.flagImageName)
        content.imageProperties.maximumSize = CGSize(width: 32, height: 24)
        cell.contentConfiguration = content

        cell.accessoryType = (indexPath == selectedIndexPath) ? .checkmark : .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            tableView.cellForRow(at: previousIndexPath)?.accessoryType = .none
        }

        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedIndexPath = indexPath
        selectedCountry = countries[indexPath.row]
                
        nextButton.isEnabled = true
        nextButton.alpha = 1.0

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

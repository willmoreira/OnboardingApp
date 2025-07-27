import UIKit

final class CountrySelectionViewController: UIViewController {

    // MARK: - Properties

    var presenter: CountrySelectionPresenterProtocol!

    private var countries: [CountrySelectionEntity.UserEntity] = []
    private var selectedCountry: CountrySelectionEntity.UserEntity?
    private var selectedIndexPath: IndexPath?

    // MARK: - UI Components

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(IconTitleTableViewCell.self, forCellReuseIdentifier: "IconTitleCell")
        table.dataSource = self
        table.delegate = self
        return table
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Avançar", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .systemGreen
        button.backgroundColor = .systemGray6
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.tintColor = .systemGreen
        button.isEnabled = false
        button.alpha = 0.3
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Avançar"
        button.accessibilityHint = "Selecione um país para ativar este botão"
        button.accessibilityTraits = .button
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter.viewDidLoad()
    }

    // MARK: - Actions

    @objc private func nextButtonTapped() {
        guard let country = selectedCountry else { return }
        let request = CountrySelectionEntity.Request(entity: country)
        presenter.didTapNext(with: request)
    }

    // MARK: - Layout

    private func setupLayout() {
        title = "Selecione o País"
        UIAccessibility.post(notification: .screenChanged, argument: self.navigationItem.titleView ?? self)
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(nextButton)
        tableView.backgroundColor = .white

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),

            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

// MARK: - CountrySelectionViewProtocol

extension CountrySelectionViewController: CountrySelectionViewProtocol {

    func showCountries(_ viewModel: CountrySelectionEntity.ViewModel) {
        self.countries = viewModel.countries
        tableView.reloadData()

        DispatchQueue.main.async {
            self.tableView.isScrollEnabled = self.tableView.contentSize.height > self.tableView.bounds.height
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension CountrySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row]
        let isSelected = (indexPath == selectedIndexPath)

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "IconTitleCell",
            for: indexPath
        ) as? IconTitleTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(title: country.name, iconName: country.flagImageName, isSelected: isSelected, iconIsSystem: false)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        selectedCountry = countries[indexPath.row]
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
        nextButton.accessibilityHint = "Avança para a próxima etapa"
        tableView.reloadData()
        UIAccessibility.post(notification: .layoutChanged, argument: nextButton)
    }
}

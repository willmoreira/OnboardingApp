import UIKit

final class CountrySelectionViewController: UIViewController {

    // MARK: - Properties

    var presenter: CountrySelectionPresenterProtocol!

    private var countries: [Country] = []
    private var selectedCountry: Country?
    private var selectedIndexPath: IndexPath?

    // MARK: - UI Components

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
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
        button.titleLabel?.textColor = .systemGreen
        button.backgroundColor = .systemGray6
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.tintColor = .systemGreen
        button.isEnabled = false
        button.alpha = 0.3
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Avançar para próxima etapa"
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
        presenter.didTapNext(with: country)
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
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

// MARK: - CountrySelectionViewProtocol

extension CountrySelectionViewController: CountrySelectionViewProtocol {
    func showCountries(_ countries: [Country]) {
        self.countries = countries
        tableView.reloadData()
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.isAccessibilityElement = true
        cell.accessibilityLabel = isSelected
            ? "\(country.name), selecionado"
            : country.name
        cell.accessibilityTraits = isSelected ? [.button, .selected] : .button

        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .systemGroupedBackground
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4

        let imageView = UIImageView(image: UIImage(named: country.flagImageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = country.name
        label.font = .systemFont(ofSize: 16, weight: .medium)

        let checkImageView = UIImageView()
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.image = isSelected ? UIImage(systemName: "checkmark.circle.fill") : nil
        checkImageView.tintColor = .systemGreen
        checkImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        let stack = UIStackView(arrangedSubviews: [imageView, label, checkImageView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false

        cardView.addSubview(stack)
        cell.contentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),

            stack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
        ])

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

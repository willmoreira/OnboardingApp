import UIKit

final class DocumentSelectionViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: DocumentSelectionPresenterProtocol!

    private var documents: [Document] = []
    private var selectedDocument: Document?
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
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        button.isAccessibilityElement = true
        button.accessibilityLabel = "Botão Avançar"
        button.accessibilityHint = "Avança para o próximo passo após selecionar um documento"

        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Selecione o Documento"
        view.backgroundColor = .systemBackground
        setupLayout()
        presenter.viewDidLoad()

        UIAccessibility.post(notification: .screenChanged, argument: title)
    }
    
    // MARK: - Actions

    @objc private func nextButtonTapped() {
        guard let document = selectedDocument else { return }
        presenter.didTapNext(with: document)
    }

    // MARK: - Layout

    private func setupLayout() {
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

// MARK: - DocumentSelectionViewProtocol

extension DocumentSelectionViewController: DocumentSelectionViewProtocol {
    
    func showDocuments(_ documents: [Document]) {
        self.documents = documents
        tableView.reloadData()
    }
    
    func saveSelectedCountryAndDocument(country: Country, document: Document) {
        UserDefaults.standard.setEncodable(country, forKey: "selectedCountry")
        UserDefaults.standard.setEncodable(document, forKey: "selectedDocument")
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension DocumentSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let doc = documents[indexPath.row]
        let isSelected = (indexPath == selectedIndexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .systemGroupedBackground
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        
        let imageView = UIImageView(image: UIImage(systemName: doc.iconName) ?? UIImage(systemName: "questionmark.circle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGreen
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = doc.name
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

        cell.isAccessibilityElement = true
        cell.accessibilityLabel = isSelected
            ? "\(doc.name). Selecionado"
            : doc.name
        cell.accessibilityHint = "Toque duas vezes para selecionar este documento."

        imageView.isAccessibilityElement = false
        label.isAccessibilityElement = false
        checkImageView.isAccessibilityElement = false
        stack.isAccessibilityElement = false
        cardView.isAccessibilityElement = false

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previous = selectedIndexPath {
            tableView.cellForRow(at: previous)?.accessoryType = .none
        }

        selectedIndexPath = indexPath
        selectedDocument = documents[indexPath.row]
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
        tableView.reloadData()

        let selectedDocName = selectedDocument?.name ?? "Documento"
        UIAccessibility.post(notification: .announcement, argument: "\(selectedDocName) selecionado")
    }
}

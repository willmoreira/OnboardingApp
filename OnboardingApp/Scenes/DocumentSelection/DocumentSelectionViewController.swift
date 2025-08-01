import UIKit

final class DocumentSelectionViewController: UIViewController {

    // MARK: - Properties

    var presenter: DocumentSelectionPresenterProtocol!

    private var documents: [DocumentSelectionEntity.UserEntity] = []
    private var selectedDocument: DocumentSelectionEntity.UserEntity?
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
        tableView.register(IconTitleTableViewCell.self, forCellReuseIdentifier: "IconTitleCell")

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

// MARK: - DocumentSelectionViewProtocol

extension DocumentSelectionViewController: DocumentSelectionViewProtocol {

    func showDocuments(_ viewModel: DocumentSelectionEntity.ViewModel) {
        self.documents = viewModel.documents
        tableView.reloadData()

        DispatchQueue.main.async {
            self.tableView.isScrollEnabled = self.tableView.contentSize.height > self.tableView.bounds.height
        }
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

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "IconTitleCell",
            for: indexPath) as? IconTitleTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(title: doc.name, iconName: doc.iconName, isSelected: isSelected, iconIsSystem: true)
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

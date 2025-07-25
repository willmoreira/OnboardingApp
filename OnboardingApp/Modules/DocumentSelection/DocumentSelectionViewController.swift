import UIKit

final class DocumentSelectionViewController: UIViewController {
    var presenter: DocumentSelectionPresenterProtocol!

    private var documents: [Document] = []
    private var selectedDocument: Document?
    private var selectedIndexPath: IndexPath?

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        title = "Selecione o Documento"
        view.backgroundColor = .systemBackground
        setupLayout()
        presenter.viewDidLoad()
    }

    private func setupLayout() {
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

    @objc private func nextButtonTapped() {
        guard let document = selectedDocument else { return }
        presenter.didTapNext(with: document)
    }
}

extension DocumentSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let doc = documents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = doc.name
        content.image = UIImage(named: doc.iconName)
        content.imageProperties.maximumSize = CGSize(width: 32, height: 24)
        cell.contentConfiguration = content

        cell.accessoryType = (indexPath == selectedIndexPath) ? .checkmark : .none

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
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

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

import UIKit

final class BirthDateViewController: UIViewController {

    // MARK: - VIP
    var presenter: BirthDatePresenterProtocol!
    private var isBirthDateValid = false

    // MARK: - UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Escolha sua data de nascimento \n\n Precisa ser maior de 18 anos"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.accessibilityLabel = "Escolha sua data de nascimento. Precisa ser maior de 18 anos."
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "pt_BR")
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.accessibilityIdentifier = "birthDatePickerIdentifier"
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        picker.isAccessibilityElement = true
        picker.accessibilityLabel = "Selecionar data de nascimento"
        picker.accessibilityHint = "Use os seletores para escolher sua data de nascimento. Deve ser maior de 18 anos."
        return picker
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
        button.accessibilityHint = "Avança para a próxima etapa se a data for válida"
        button.accessibilityTraits = .button
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Data de Nascimento"
        view.backgroundColor = .systemBackground
        setupLayout()
        setPickerInitalDate()
        view.accessibilityElements = [titleLabel, datePicker, nextButton]
    }

    private func setPickerInitalDate() {
        if let eighteenYearsAgo = Calendar.current.date(byAdding: .year, value: -18, to: Date()) {
            datePicker.date = eighteenYearsAgo
            let entity = BirthDateEntity.UserEntity(date: eighteenYearsAgo)
            presenter?.validateBirthDate(BirthDateEntity.Request(entity: entity))
        }
    }

    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(datePicker)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.widthAnchor.constraint(equalToConstant: 196)
        ])
    }

    // MARK: - Actions
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let entity = BirthDateEntity.UserEntity(date: sender.date)
        presenter.validateBirthDate(BirthDateEntity.Request(entity: entity))
    }

    @objc private func didTapNext() {
        presenter.goToDocumentCapture()
    }

    private func showUnderageAlert() {
        let alert = UIAlertController(
            title: "Idade inválida",
            message: "Você precisa ter pelo menos 18 anos para continuar.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.resetDatePickerToEighteenYearsAgo()
        })
        present(alert, animated: true)
    }

    private func resetDatePickerToEighteenYearsAgo() {
        guard let eighteenYearsAgo = Calendar.current.date(byAdding: .year, value: -18, to: Date()) else { return }
        datePicker.setDate(eighteenYearsAgo, animated: true)
        let entity = BirthDateEntity.UserEntity(date: eighteenYearsAgo)
        presenter.validateBirthDate(BirthDateEntity.Request(entity: entity))
    }
}

extension BirthDateViewController: BirthDateViewProtocol {

    func displayValidation(_ viewModel: BirthDateEntity.ViewModel) {
        isBirthDateValid = viewModel.isValid
        nextButton.isEnabled = viewModel.isValid
        nextButton.alpha = viewModel.isValid ? 1.0 : 0.3

        if !viewModel.isValid {
            showUnderageAlert()
        }
    }
}

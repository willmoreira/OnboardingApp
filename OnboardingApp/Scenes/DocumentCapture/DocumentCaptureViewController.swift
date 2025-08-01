import UIKit

final class DocumentCaptureViewController: UIViewController {

    // MARK: - Properties

    var presenter: DocumentCapturePresenterProtocol!

    // MARK: - UI Components

    private lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.layer.borderColor = UIColor.lightGray.cgColor
        img.layer.borderWidth = 1
        img.accessibilityIdentifier = "capturedImage"
        img.clipsToBounds = true
        return img
    }()

    private lazy var captureButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .systemGreen
        button.backgroundColor = .systemGray6
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.tintColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Capturar Documento", for: .normal)
        button.accessibilityIdentifier = "captureButton"
        button.addTarget(self, action: #selector(captureTapped), for: .touchUpInside)
        return button
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .systemGreen
        button.backgroundColor = .systemGray6
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.tintColor = .systemGreen
        button.isEnabled = false
        button.alpha = 0.3
        button.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        return button
    }()

    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Limpar Captura", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .systemRed
        button.backgroundColor = .systemGray6
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return button
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()

    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()

    private lazy var documentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()

    private lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()

    private lazy var loadingOverlay: UIView = {
        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlay.isHidden = true
        return overlay
    }()

    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [clearButton, sendButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Captura de Documento"
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()

        setupLayout()
        configureAccessibility()
    }

    // MARK: - Actions

    @objc private func clearTapped() {
        imageView.image = nil
        sendButton.isEnabled = false
        sendButton.alpha = 0.3
        clearButton.isEnabled = false
        clearButton.alpha = 0.3
    }

    @objc private func captureTapped() {
        presenter.didTapCapture()
    }

    @objc private func sendTapped() {
        presenter.didTapSend()
    }

    private func configureAccessibility() {
        countryLabel.isAccessibilityElement = true
        countryLabel.accessibilityLabel = "País selecionado"
        countryLabel.accessibilityValue = countryLabel.text

        documentLabel.isAccessibilityElement = true
        documentLabel.accessibilityLabel = "Documento selecionado"
        documentLabel.accessibilityValue = documentLabel.text

        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Imagem do documento capturado"
        imageView.accessibilityTraits = .image

        captureButton.isAccessibilityElement = true
        captureButton.accessibilityLabel = "Capturar documento"
        captureButton.accessibilityHint = "Abre a câmera para capturar uma imagem do documento"

        sendButton.isAccessibilityElement = true
        sendButton.accessibilityLabel = "Enviar documento"
        sendButton.accessibilityHint = "Envia a imagem capturada do documento"

        clearButton.isAccessibilityElement = true
        clearButton.accessibilityLabel = "Limpar captura"
        clearButton.accessibilityHint = "Remove a imagem capturada"

        activityIndicator.isAccessibilityElement = true
        activityIndicator.accessibilityLabel = "Carregando"
        activityIndicator.accessibilityTraits = .updatesFrequently
    }

    // MARK: - Layout

    private func setupLayout() {
        clearButton.isEnabled = false
        clearButton.alpha = 0.3

        view.addSubview(countryLabel)
        view.addSubview(documentLabel)
        view.addSubview(birthDateLabel)
        view.addSubview(imageView)
        view.addSubview(captureButton)
        view.addSubview(buttonStackView)
        view.addSubview(loadingOverlay)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            countryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            documentLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 8),
            documentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            birthDateLabel.topAnchor.constraint(equalTo: documentLabel.bottomAnchor, constant: 8),
            birthDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            imageView.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40),

            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            captureButton.heightAnchor.constraint(equalToConstant: 32),
            captureButton.widthAnchor.constraint(equalToConstant: 200),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            loadingOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            loadingOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.bringSubviewToFront(activityIndicator)
        view.bringSubviewToFront(loadingOverlay)
    }
}

// MARK: - DocumentCaptureViewProtocol

extension DocumentCaptureViewController: DocumentCaptureViewProtocol {

    func showCapturedImage(_ image: UIImage) {
        imageView.image = image
        sendButton.isEnabled = true
        sendButton.alpha = 1.0
        clearButton.isEnabled = true
        clearButton.alpha = 1.0
    }

    func showLoading(_ show: Bool) {
        loadingOverlay.isHidden = !show

        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func showSuccessMessage() {
        let alert = UIAlertController(title: "Sucesso", message: "Documento enviado com sucesso!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.presenter.didConfirmSuccess()
        })
        present(alert, animated: true)

        UIAccessibility.post(notification: .announcement, argument: "Documento enviado com sucesso")
    }

    func showErrorMessage() {
        let alert = UIAlertController(title: "Erro", message: "Erro ao carregar a imagem", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

        UIAccessibility.post(notification: .announcement, argument: "Erro ao carregar a imagem")
    }

    func displayUserSelection(_ viewModel: UserSelectionEntity.ViewModel) {
        countryLabel.text = "País: \(viewModel.countryName)"
        documentLabel.text = "Documento: \(viewModel.documentName)"
        birthDateLabel.text = "Data de nascimento: \(viewModel.birthDateFormatted)"

        countryLabel.accessibilityValue = countryLabel.text
        documentLabel.accessibilityValue = documentLabel.text
        birthDateLabel.accessibilityValue = birthDateLabel.text
    }
}

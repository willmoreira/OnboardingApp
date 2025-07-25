import UIKit

final class DocumentCaptureViewController: UIViewController {
    var presenter: DocumentCapturePresenterProtocol!

    private lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.layer.borderColor = UIColor.lightGray.cgColor
        img.layer.borderWidth = 1
        img.clipsToBounds = true
        return img
    }()

    private lazy var captureButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Capturar Documento", for: .normal)
        btn.addTarget(self, action: #selector(captureTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Enviar", for: .normal)
        btn.isEnabled = false
        btn.alpha = 0.5
        btn.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        return btn
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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Captura de Documento"
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(countryLabel)
        view.addSubview(documentLabel)
        view.addSubview(imageView)
        view.addSubview(captureButton)
        view.addSubview(sendButton)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            countryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            documentLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 8),
            documentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            imageView.topAnchor.constraint(equalTo: documentLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalToConstant: 300),

            captureButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            sendButton.topAnchor.constraint(equalTo: captureButton.bottomAnchor, constant: 16),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            activityIndicator.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 24),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func captureTapped() {
        presenter.didTapCapture()
    }

    @objc private func sendTapped() {
        presenter.didTapSend()
    }
}

extension DocumentCaptureViewController: DocumentCaptureViewProtocol {
    func showCapturedImage(_ image: UIImage) {
        imageView.image = image
        sendButton.isEnabled = true
        sendButton.alpha = 1.0
    }

    func showLoading(_ show: Bool) {
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    func showSuccessMessage() {
        let alert = UIAlertController(title: "Sucesso", message: "Documento enviado com sucesso!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showErrorMessage() {
        let alert = UIAlertController(title: "Erro", message: "Erro ao carregar a imagem", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func displaySelectedCountry(_ name: String) {
        countryLabel.text = "País selecionado: \(name)"
    }

    func displaySelectedDocument(_ name: String) {
        documentLabel.text = "Documento selecionado: \(name)"
    }
}

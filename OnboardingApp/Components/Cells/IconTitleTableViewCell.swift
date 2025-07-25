import UIKit
import CoreKit

final class IconTitleTableViewCell: UITableViewCell {

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let checkImageView = UIImageView()
    private let cardView = UIView()
    private let stack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none

        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .systemGroupedBackground
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        contentView.addSubview(cardView)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.tintColor = .systemGreen

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)

        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        checkImageView.tintColor = .systemGreen

        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(iconImageView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(checkImageView)

        cardView.addSubview(stack)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            stack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
        ])
    }

    func configure(title: String, iconName: String, isSelected: Bool, iconIsSystem: Bool = false) {
        let image = iconIsSystem
            ? UIImage(systemName: iconName) ?? UIImage(systemName: "questionmark.circle")
            : UIImage(named: iconName)

        iconImageView.image = image
        titleLabel.text = title
        checkImageView.image = isSelected ? UIImage(systemName: "checkmark.circle.fill") : nil

        isAccessibilityElement = true
        accessibilityLabel = isSelected ? "\(title). Selecionado" : title
        accessibilityTraits = isSelected ? [.button, .selected] : .button
        accessibilityHint = "Toque duas vezes para selecionar."
    }
}

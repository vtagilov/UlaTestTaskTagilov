//
//  ServiceTableViewCell.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 27.03.2024.
//

import UIKit

final class ServiceTableViewCell: UITableViewCell {
    static let identifier = String(describing: ServiceTableViewCell.self)
    
    private let icon = UIImageView()
    private let nameLabel = UILabel()
    private let discriptionLabel = UILabel()
    private let selectView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpUI()
    }
    
    func configureCell(model: ServiceModel) {
        fetchIcon(url: model.icon_url)
        nameLabel.text = model.name
        discriptionLabel.text = model.description
    }
    
    private func setIcon(image: UIImage = UIImage(systemName: "wifi.exclamationmark")!) {
        DispatchQueue.main.async {
            self.icon.image = image
        }
    }
    
    private func fetchIcon(url: String) {
        NetworkManager.fetchData(urlString: url) { responce in
            if responce.error != nil {
                self.setIcon()
                return
            }
            guard let data = responce.data else {
                self.setIcon()
                return
            }
            guard let image = UIImage(data: data) else {
                self.setIcon()
                return
            }
            self.setIcon(image: image)
        }
    }
    
    private func setUpUI() {
        self.backgroundColor = .black
        selectView.contentMode = .scaleAspectFit
        selectView.image = UIImage(systemName: "chevron.right")
        selectView.tintColor = .gray
        icon.contentMode = .scaleAspectFit
        discriptionLabel.numberOfLines = 0
        discriptionLabel.font = .systemFont(ofSize: 12)
        discriptionLabel.baselineAdjustment = .alignCenters
        configureConstraints()
    }
}

extension ServiceTableViewCell {
    private func configureConstraints() {
        enum Constants {
            static let verticalOffset = 12.0
            static let horizontalOffset = 8.0
            static let horizontalSpacing = 16.0
            static let iconSize = 48.0
            static let selectViewSize = 16.0
        }
        let nameLabelHeight = (contentView.frame.height - Constants.verticalOffset * 2) / 3
        let discriptionLabelHeight = nameLabelHeight * 2
        for subview in [icon, nameLabel, discriptionLabel, selectView] {
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalOffset),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalOffset),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalOffset),
            icon.heightAnchor.constraint(equalTo: icon.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalOffset),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight),
            nameLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Constants.horizontalSpacing),
            nameLabel.trailingAnchor.constraint(equalTo: selectView.leadingAnchor, constant: -Constants.horizontalSpacing),
            
            discriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            discriptionLabel.heightAnchor.constraint(equalToConstant: discriptionLabelHeight),
            discriptionLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Constants.horizontalSpacing),
            discriptionLabel.trailingAnchor.constraint(equalTo: selectView.leadingAnchor, constant: -Constants.horizontalSpacing),
            
            selectView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalOffset),
            selectView.heightAnchor.constraint(equalToConstant: Constants.selectViewSize),
            selectView.widthAnchor.constraint(equalToConstant: Constants.selectViewSize)
        ])
    }
}

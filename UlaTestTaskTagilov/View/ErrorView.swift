//
//  ErrorView.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 28.03.2024.
//

import UIKit

protocol ErrorViewDelegate {
    func tryAgainAction()
}

extension ViewController: ErrorViewDelegate {
    func tryAgainAction() {
        fetchServices()
        errorView.isHidden = true
    }
}

final class ErrorView: UIView {
    private let label = UILabel()
    private let button = UIButton()
    var delegate: ErrorViewDelegate?
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setUpUI()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(error: NetworkError) {
        self.label.text = error.description
    }
    
    private func setUpUI() {
        label.numberOfLines = 0
        label.textAlignment = .center
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.setTitle("Попробовать снова", for: .normal)
        button.addTarget(self, action: #selector(tryAgainAction), for: .touchUpInside)
    }
    
    @objc private func tryAgainAction() {
        delegate?.tryAgainAction()
    }
}

extension ErrorView {
    private func configureConstraints() {
        for subview in [label, button] {
            self.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor),
                label.topAnchor.constraint(equalTo: topAnchor),
                label.bottomAnchor.constraint(equalTo: centerYAnchor),
                
                button.topAnchor.constraint(equalTo: label.bottomAnchor),
                button.bottomAnchor.constraint(equalTo: bottomAnchor),
                button.leadingAnchor.constraint(equalTo: leadingAnchor),
                button.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
    }
}

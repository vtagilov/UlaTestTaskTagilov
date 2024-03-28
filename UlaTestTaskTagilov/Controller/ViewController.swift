//
//  ViewController.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 27.03.2024.
//

import UIKit

final class ViewController: UIViewController {
    private let tableView = ServiceTableView()
    internal var errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        fetchServices()
        errorView.delegate = self
        errorView.isHidden = true
        self.title = "Сервисы"
    }
    
    private func setError(error: NetworkError) {
        DispatchQueue.main.async {
            self.errorView.configureView(error: error)
            self.errorView.isHidden = false
        }
    }
    
    internal func fetchServices() {
        NetworkManager.fetchServices { responce in
            if let error = responce.error {
                self.setError(error: error)
                return
            }
            guard let data = responce.data else {
                self.setError(error: .dataEmpty)
                return
            }
            guard let models = ServiceResponseParser.parseWeatherData(data) else {
                self.setError(error: .dataEmpty)
                return
            }
            DispatchQueue.main.async {
                self.tableView.setModels(models.body.services)
            }
        }
    }
}

extension ViewController {
    private func configureConstraints() {
        enum Constants {
            static let errorViewHeight = 150.0
            static let errorViewWidth = 250.0
        }
        for subview in [tableView, errorView] {
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.heightAnchor.constraint(equalToConstant: Constants.errorViewHeight),
            errorView.widthAnchor.constraint(equalToConstant: Constants.errorViewWidth)
        ])
    }
}

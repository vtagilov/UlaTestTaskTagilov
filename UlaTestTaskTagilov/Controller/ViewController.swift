//
//  ViewController.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 27.03.2024.
//

import UIKit

final class ViewController: UIViewController {
    private let tableView = ServiceTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        fetchServices()
        self.title = "Сервисы"
    }
    
    private func setError(error: NetworkError) {
        print("setError")
    }
    
    private func fetchServices() {
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
        for subview in [tableView] {
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

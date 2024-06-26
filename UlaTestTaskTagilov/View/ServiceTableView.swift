//
//  ServiceTableView.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 27.03.2024.
//

import UIKit

final class ServiceTableView: UITableView {
    private var models = [ServiceModel]()
    
    init() {
        super.init(frame: .zero, style: .plain)
        register(ServiceTableViewCell.self, forCellReuseIdentifier: ServiceTableViewCell.identifier)
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModels(_ models: [ServiceModel]) {
        self.models = models
        self.reloadData()
    }
}

extension ServiceTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.identifier, for: indexPath) as? ServiceTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(model: models[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        if let url = URL(string: model.link) {
            UIApplication.shared.open(url)
        }
        tableView.cellForRow(at: indexPath)?.isSelected = false
        return
    }
}

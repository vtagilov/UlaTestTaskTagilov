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
        tableView.setModels([.init(name: "ВКонтакте", description: "Самая популярная соцсеть и первое суперприложение в России", link: "https://vk.com/", icon_url: "https://publicstorage.hb.bizmrg.com/sirius/vk.png")])
        configureConstraints()
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

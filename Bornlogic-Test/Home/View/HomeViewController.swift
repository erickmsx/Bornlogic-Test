//
//  ViewController.swift
//  Bornlogic-Test
//
//  Created by Erick Martins on 11/05/24.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func reloadTableView()
}

class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol?
    var items: [HomeModel] = []
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        navigationItem.title = "Home"
        view.backgroundColor = .blue
        tableView.dataSource = self
        tableView.delegate = self
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        
        cell.titleLabel.text = presenter?.item(at: indexPath.row)?.title
        cell.titleLabel.textColor = presenter?.cellTextColor()
        cell.titleLabel.font = UIFont.systemFont(ofSize: presenter?.cellTextFontSize() ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


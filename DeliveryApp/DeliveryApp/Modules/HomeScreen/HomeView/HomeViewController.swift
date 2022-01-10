//
//  HomeViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var presenter: HomePresenterProtocol!
    private var cellModels = [TableViewCompatible]() {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor(red: 34/255, green: 164/255, blue: 97/255, alpha: 1)
        presenter.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "Test")
        tableView.dataSource = self
    }
    
    @IBAction func filtersTapped(_ sender: Any) {
        presenter.showFilters()
    }
}

extension HomeViewController: HomeViewInput {
    
    func setupTableView(models: [TableViewCompatible]) {
        self.cellModels = models
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        return model.cellForTableView(tableView: tableView, delegate: self)
    }
}

extension HomeViewController: MainTableViewDelegate {
    
    func selectRaw(with id: String) {
        presenter.showDetailPlace(placeId: id)
    }
}

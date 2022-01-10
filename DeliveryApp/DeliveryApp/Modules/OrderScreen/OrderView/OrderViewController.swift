//
//  OrderViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class OrderViewController: BaseViewController {
    
    var presenter: OrderPresenterProtocol!
    
    var cellModels = [TableViewCompatible]() {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "OrderPositionTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderPosition")
        tableView.register(UINib(nibName: "OrderCheckoutTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderCheckout")
        tableView.dataSource = self
    }
}

extension OrderViewController: OrderViewInput {
    
    func setupTableView(cellModels: [TableViewCompatible]) {
        self.cellModels = cellModels
    }
}

extension OrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        let cell = model.cellForTableView(tableView: tableView, delegate: self)
        return cell
    }
}

extension OrderViewController: MainTableViewDelegate {
    
    func checkoutOrder() {
        presenter.checkoutOrder()
    }
}

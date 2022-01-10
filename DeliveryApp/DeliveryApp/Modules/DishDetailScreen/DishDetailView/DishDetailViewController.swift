//
//  DishDetailViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import UIKit
import Kingfisher

class DishDetailViewController: BaseViewController {
    
    var presenter: DishDetailPresenterProtocol!
    private var cellModels = [TableViewCompatible]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "DishDetailTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "DishDetailTitle")
        tableView.register(UINib(nibName: "DishChoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "DishChoice")
        tableView.register(UINib(nibName: "OrderDishTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderDish")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        presenter.closeView()
    }
}

extension DishDetailViewController: DishDetailViewInput {
    
    func setupTableView(cellModels: [TableViewCompatible], imageURL: String) {
        self.cellModels = cellModels
        guard let imageView = headerView.subviews.first as? UIImageView else { return }
        imageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "foodPlaceholder"), options: [.cacheMemoryOnly])
    }
}

extension DishDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        let cell = model.cellForTableView(tableView: tableView, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}

extension DishDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = cellModels[indexPath.row] as? DishChoiceTableCellModel, indexPath.row > 0 else {
            return
        }
        presenter.selectChoice(with: model.name)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -scrollView.contentOffset.y
        imageHeightConstraint?.constant = max(headerView.bounds.height, headerView.bounds.height + offsetY)
    }
}

extension DishDetailViewController: MainTableViewDelegate {
    
    func addOrder() {
        presenter.setDishOrder()
    }
}

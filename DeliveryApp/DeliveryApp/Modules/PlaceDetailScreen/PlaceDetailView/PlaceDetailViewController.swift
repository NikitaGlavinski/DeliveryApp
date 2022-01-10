//
//  placeDetailViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class PlaceDetailViewController: BaseViewController {
    
    var presenter: PlaceDetailPresenterProtocol!
    private var selectedCategoryIndex: Int = 0
    private var cellModels = [TableViewCompatible]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "DetailTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTitle")
        tableView.register(UINib(nibName: "FeaturedItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailFeature")
        tableView.register(UINib(nibName: "DetailCategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCategories")
        tableView.register(UINib(nibName: "DetailDishTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailDish")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension PlaceDetailViewController: PlaceDetailViewInput {
    
    func setupTableView(models: [TableViewCompatible]) {
        cellModels = models
        tableView.reloadData()
    }
    
    func updateTableView(models: [TableViewCompatible], fromIndex: Int, toIndex: Int) {
        var deleteArray = [IndexPath]()
        for index in 3..<cellModels.count {
            deleteArray.append(IndexPath(row: index, section: 0))
            cellModels.remove(at: 3)
        }
        tableView.deleteRows(at: deleteArray, with: .none)
        var updateArray = [IndexPath]()
        for index in 3..<models.count {
            updateArray.append(IndexPath(row: index, section: 0))
            cellModels.append(models[index])
        }
        tableView.insertRows(at: updateArray, with: .fade)

    }
    
}

extension PlaceDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        let cell = model.cellForTableView(tableView: tableView, delegate: self)
        return cell
    }
}

extension PlaceDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = cellModels[indexPath.row] as? DetailDishTableCellModel, indexPath.row > 2 else {
            return
        }
        presenter.showDishDetail(dishId: model.dish.id)
    }
}

extension PlaceDetailViewController: MainTableViewDelegate {
    
    func selectCategory(category: String) {
        presenter.filterDishes(by: category)
    }
    
    func selectDish(with id: Int) {
        presenter.showDishDetail(dishId: id)
    }
}

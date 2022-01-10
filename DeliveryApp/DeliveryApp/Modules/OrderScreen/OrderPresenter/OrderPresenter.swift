//
//  OrderPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation
import RxSwift

class OrderPresenter {
    weak var view: OrderViewInput!
    var interactor: OrderInterctorInput!
    var router: OrderRouter!
    
    private let disposeBag = DisposeBag()
    private var orders = [DishesModel]()
    
    private func setupTableView() {
        var cellModels = [TableViewCompatible]()
        var subtotal: Float = 0.0
        for order in orders {
            subtotal += order.price
            let boolValue = cellModels.contains(where: { cellModel in
                guard let orderModel = cellModel as? OrderPositionTableCellModel else {
                    return false
                }
                return orderModel.title == order.name
            })
            if boolValue {
                continue
            }
            let filterCount = orders.filter({$0.id == order.id}).count
            cellModels.append(OrderPositionTableCellModel(title: order.name, description: order.description, count: filterCount, price: order.price))
        }
        let total = Float(Int((subtotal * 0.9) * 100)) / 100
        cellModels.append(OrderCheckoutTableCellModel(subTotal: subtotal, delivery: 0.0, total: total))
        view.setupTableView(cellModels: cellModels)
    }
}

extension OrderPresenter: OrderPresenterProtocol {
    
    func viewWillAppear() {
        view.showLoader()
        guard let ordersObtainer = interactor.getUserOrders() else { return}
        ordersObtainer
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] orders in
                self?.view.hideLoader()
                self?.orders = orders
                self?.setupTableView()
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func checkoutOrder() {
        guard orders.count > 0 else { return }
        view.showLoader()
        guard let orderCheckout = interactor.checkoutOrders() else { return }
        orderCheckout
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] complete in
                self?.view.hideLoader()
                self?.orders = []
                self?.setupTableView()
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
}

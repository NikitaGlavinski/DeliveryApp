//
//  FirebaseService.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import Foundation
import Firebase
import RxSwift

protocol FirebaseServiceProtocol {
    func getPlaces() -> Single<[PlaceModel]>
    func getFilters() -> Single<[FiltersModel]>
    func setFilter(filter: FiltersModel) -> Single<String>
    func clearAllFilters(filterField: String, filterValue: Any) -> Single<String>
    func getPriceFilters() -> Single<[PriceFilter]>
    func setPriceFilter(priceFilter: PriceFilter) -> Single<String>
    func clearAllPriceFilters() -> Single<String>
    func getPlace(placeId: String) -> Single<PlaceModel>
    func getDishes(placeId: String) -> Single<[DishesModel]>
    func getDish(dishId: Int, placeId: String) -> Single<DishesModel>
    func setUserOrder(dish: DishesModel, userToken: String) -> Single<String>
    func getUserOrders(userToken: String) -> Single<[DishesModel]>
    func deleteOrders(userToken: String) -> Single<String>
}

class FirebaseService {
    
    private let db = Firestore.firestore()
    
    private func getData<T: Decodable>(path: String, decodeType: T.Type) -> Single<T> {
        Single<T>.create { [weak self] observer -> Disposable in
            self?.db.document(path).getDocument { snapshot, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard
                    let document = snapshot,
                    let data = document.data()
                else {
                    observer(.failure(NetworkError.noData))
                    return
                }
                do {
                    let model = try DictionaryDecoder().decode(data, decodeType: decodeType)
                    observer(.success(model))
                } catch let error {
                    observer(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func getListData<T: Decodable>(path: String, decodeType: T.Type) -> Single<[T]> {
        Single<[T]>.create { [weak self] observer -> Disposable in
            self?.db.collection(path).getDocuments { snapshot, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard let snapshot = snapshot else {
                    observer(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = DictionaryDecoder()
                    let models = try snapshot.documents.compactMap({try decoder.decode($0.data(), decodeType: decodeType)})
                    observer(.success(models))
                } catch let error {
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    private func setData<T: Encodable>(path: String, value: T) -> Single<String> {
        Single<String>.create { [weak self] observer -> Disposable in
            guard let dictionary = try? DictionaryEncoder().encode(value) else {
                observer(.failure(NetworkError.uncategorized))
                return Disposables.create()
            }
            self?.db.document(path).setData(dictionary, completion: { error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                observer(.success("Ok"))
            })
            return Disposables.create()
        }
    }
    
    private func updateCollectionProperty(path: String, key: String, value: Any, filterField: String, filterValue: Any) -> Single<String> {
        Single<String>.create { [weak self] observer -> Disposable in
            self?.db.collection(path).whereField(filterField, isEqualTo: filterValue).getDocuments { snapshot, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                var counter: Int = 0
                snapshot?.documents.forEach({ document in
                    document.reference.updateData([key: value]) { error in
                        counter += 1
                        if let error = error {
                            observer(.failure(error))
                            return
                        }
                        if counter == snapshot?.documents.count {
                            observer(.success("Ok"))
                        }
                    }
                })
            }
            return Disposables.create()
        }
    }
    
    private func updateCollectionProperty(path: String, key: String, value: Any) -> Single<String> {
        Single<String>.create { [weak self] observer -> Disposable in
            self?.db.collection(path).getDocuments { snapshot, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                var counter: Int = 0
                snapshot?.documents.forEach({ document in
                    document.reference.updateData([key: value]) { error in
                        counter += 1
                        if let error = error {
                            observer(.failure(error))
                            return
                        }
                        if counter == snapshot?.documents.count {
                            observer(.success("Ok"))
                        }
                    }
                })
            }
            return Disposables.create()
        }
    }
    
    private func deleteAllDocuments(path: String) -> Single<String> {
        Single<String>.create { [weak self] observer -> Disposable in
            self?.db.collection(path).getDocuments(completion: { snapshot, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                var counter: Int = 0
                snapshot?.documents.forEach({ document in
                    counter += 1
                    document.reference.delete { error in
                        if let error = error {
                            observer(.failure(error))
                            return
                        }
                        if counter == snapshot?.documents.count {
                            observer(.success("Ok"))
                        }
                    }
                })
            })
            return Disposables.create()
        }
    }
}

extension FirebaseService: FirebaseServiceProtocol {
    func getPlaces() -> Single<[PlaceModel]> {
        getListData(path: "places", decodeType: PlaceModel.self)
    }
    
    func getFilters() -> Single<[FiltersModel]> {
        getListData(path: "foodTypes", decodeType: FiltersModel.self)
    }
    
    func setFilter(filter: FiltersModel) -> Single<String> {
        setData(path: "foodTypes/\(filter.id)", value: filter)
    }
    
    func clearAllFilters(filterField: String, filterValue: Any) -> Single<String> {
        updateCollectionProperty(path: "foodTypes", key: "isSelected", value: false, filterField: filterField, filterValue: filterValue)
    }
    
    func getPriceFilters() -> Single<[PriceFilter]> {
        getListData(path: "priceFilter", decodeType: PriceFilter.self)
    }
    
    func setPriceFilter(priceFilter: PriceFilter) -> Single<String> {
        setData(path: "priceFilter/\(priceFilter.id)", value: priceFilter)
    }
    
    func clearAllPriceFilters() -> Single<String> {
        updateCollectionProperty(path: "priceFilter", key: "isSelected", value: false)
    }
    
    func getPlace(placeId: String) -> Single<PlaceModel> {
        getData(path: "places/\(placeId)", decodeType: PlaceModel.self)
    }
    
    func getDishes(placeId: String) -> Single<[DishesModel]> {
        getListData(path: "places/\(placeId)/dishes", decodeType: DishesModel.self)
    }
    
    func getDish(dishId: Int, placeId: String) -> Single<DishesModel> {
        getData(path: "places/\(placeId)/dishes/\(dishId)", decodeType: DishesModel.self)
    }
    
    func setUserOrder(dish: DishesModel, userToken: String) -> Single<String> {
        setData(path: "users/\(userToken)/orders/\(UUID().uuidString)", value: dish)
    }
    
    func getUserOrders(userToken: String) -> Single<[DishesModel]> {
        getListData(path: "users/\(userToken)/orders", decodeType: DishesModel.self)
    }
    
    func deleteOrders(userToken: String) -> Single<String> {
        deleteAllDocuments(path: "users/\(userToken)/orders")
    }
}

//
//  ProfileViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenterProtocol!
    private var cellModels: [SettingsCellModel] = [
        SettingsCellModel(image: UIImage(systemName: "person.fill")!, title: "Profile Information", subTitle: "Change your account information"),
        SettingsCellModel(image: UIImage(systemName: "lock.fill")!, title: "Change Password", subTitle: "Change your password"),
        SettingsCellModel(image: UIImage(systemName: "creditcard.fill")!, title: "Payment Methods", subTitle: "Add your credit & debit cards"),
        SettingsCellModel(image: UIImage(systemName: "location.fill")!, title: "Locations", subTitle: "Add or remove your delivery locations"),
        SettingsCellModel(image: UIImage(systemName: "message.fill")!, title: "Add Social Account", subTitle: "Add Facebook, Twitter etc"),
        SettingsCellModel(image: UIImage(systemName: "arrowshape.turn.up.forward.fill")!, title: "Refer to Friends", subTitle: "Get $10 for reffering friends")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

}

extension ProfileViewController: ProfileViewInput {
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTitle") as! TitleProfileTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsProfile") as! SettingsProfileTableViewCell
            cell.configureCell(with: cellModels[indexPath.row - 1])
            return cell
        }
    }
}

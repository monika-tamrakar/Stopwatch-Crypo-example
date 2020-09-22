//
//  DashboardVC.swift
//  DemoApp
//
//  Created by Monika on 22/09/20.
//

import UIKit

class DashboardVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Welcome \(UserProvider.shared.user?.name ?? "")"
    }

}

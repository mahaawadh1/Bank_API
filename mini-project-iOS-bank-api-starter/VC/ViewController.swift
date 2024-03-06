//
//  ViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import UIKit
import Eureka

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section()
            <<< ButtonRow() {
                $0.title = "Create Account"
                $0.cell.tintColor = .blue  // Set button color
                }.onCellSelection { cell, row in
                    self.createAccountButtonTapped()
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textAlignment = .center  // Center align the button text
            }
            
            <<< ButtonRow() {
                $0.title = "Sign In"
                $0.cell.tintColor = .green  // Set button color
                }.onCellSelection { cell, row in
                    self.signInButtonTapped()
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textAlignment = .center  // Center align the button text
            }
    }

    func createAccountButtonTapped() {
        let accountCreationVC = AccountCreationViewController()
        navigationController?.pushViewController(accountCreationVC, animated: true)
    }

    func signInButtonTapped() {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
}

//
//  ViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createAccountButtonTapped(_ sender: Any) {
        let accountCreationVC = AccountCreationViewController()
        let navController = UINavigationController(rootViewController: accountCreationVC)
    
        present(navController, animated: true, completion: nil)
    }
}

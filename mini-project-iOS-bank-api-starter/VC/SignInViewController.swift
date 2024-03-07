//
//  singViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by maha on 06/03/2024.
//
import UIKit
import Eureka

class SignInViewController: FormViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Sign In")
            <<< TextRow() {
                $0.title = "Username"
                $0.placeholder = "Enter username"
                $0.tag = "username"
            }
            <<< PasswordRow() {
                $0.title = "Password"
                $0.placeholder = "Enter password"
                $0.tag = "password"
            }
        
        
        +++ Section()
            <<< ButtonRow() {
                $0.title = "Sign In"
                }.onCellSelection { cell, row in
                    self.submitTapped()
            }
    }
    
    @objc func submitTapped() {
        let errors = form.validate()
        guard errors.isEmpty else {
            print("Something is missing!")
            print(errors)
            let countError = errors.count
            presentAlertWithTitle(title: "Error!!", message: "\(countError) TextFields empty")
            return
        }

        guard let usernameRow = form.rowBy(tag: "username") as? TextRow,
              let passwordRow = form.rowBy(tag: "password") as? PasswordRow,
              let username = usernameRow.value,
              let password = passwordRow.value else {
            print("Failed to retrieve form values.")
            return
        }
        
        let user = User(username: username, email: nil, password: password
)
        
        NetworkManager.shared.signin(user: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tokenResponse):
                    print(tokenResponse.token)
                    
                    // Proceed with navigation or any other action
                    let profileVC = ProfileViewController()
                    profileVC.token = tokenResponse.token
                    self?.navigationController?.pushViewController(profileVC, animated: true)
                    
                case .failure(let error):
                    print("Sign-in failed: \(error)")
                
                }
            }
        }
    }
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

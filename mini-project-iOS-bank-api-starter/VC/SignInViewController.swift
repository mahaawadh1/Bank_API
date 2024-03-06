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
    
    @objc func submitTapped(){
            
            let errors = form.validate()
            guard errors.isEmpty else{
                print("Somthing is missing!")
                print(errors)
                let countError = errors.count
                presentAlertWithTitle(title: "error!!", message: " \(countError) TextFields empty")
                return
            }

            
            let nameRow: TextRow? = form.rowBy(tag: "username")
            let name = nameRow?.value ?? ""
            
            let passwordRow: PasswordRow? = form.rowBy(tag: "Password")
            let password = passwordRow?.value ?? ""
            
            let user = User(username: name, email: nil, password: password)
            
            
            NetworkManager.shared.signup(user: user) { success in
                DispatchQueue.main.async {

                    
                    switch success{
                    case .success(let tokenResponse):
                        print(tokenResponse.token)
                        
                        
                        //Navigate to Profile page
                        let profileVC = ProfileViewController()
                        self.navigationController?.pushViewController(profileVC, animated: true)
                        
                
                    case .failure(let error):
                        print(error)
                    }
                    
                }
            }
            
            
            func presentAlertWithTitle(title: String, message: String) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true, completion: nil)
            }
        }
        
    }

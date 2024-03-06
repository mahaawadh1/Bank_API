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
                    self.signIn()
            }
    }
    
    func signIn() {
        let valuesDictionary = form.values()
        
        guard let username = valuesDictionary["username"] as? String,
              let password = valuesDictionary["password"] as? String else {
            // Handle missing values
            return
        }
        
        // Call the function to send the data to the server
        sendSignInRequest(username: username, password: password)
    }
    
    func sendSignInRequest(username: String, password: String) {
        let url = URL(string: "https://coded-bank-api.eapi.joincoded.com/signin")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error serializing JSON: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response here
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
             
            }
            
    
            if let data = data, let responseData = String(data: data, encoding: .utf8) {
                print("Response data: \(responseData)")
            }
        }.resume()
    }
}

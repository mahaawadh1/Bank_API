//
//  AccountCreationViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by maha on 06/03/2024.
//

import UIKit
import Eureka

class AccountCreationViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Account Information")
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
            <<< TextRow() {
                $0.title = "Image URL"
                $0.placeholder = "Enter image URL"
                $0.tag = "imageURL"
            }
        
        +++ Section()
            <<< ButtonRow() {
                $0.title = "Create Account"
                }.onCellSelection { cell, row in
                    self.createAccount()
            }
    }
    
    func createAccount() {
        let valuesDictionary = form.values()
        
        guard let username = valuesDictionary["username"] as? String,
              let password = valuesDictionary["password"] as? String,
              let imageURL = valuesDictionary["imageURL"] as? String else {
            // Handle missing values
            return
        }
        
        // Call the function to send the data to the server
        sendAccountCreationRequest(username: username, password: password, imageURL: imageURL)
    }
    
    func sendAccountCreationRequest(username: String, password: String, imageURL: String) {
        // Prepare your URLRequest here
        let url = URL(string: "https://coded-bank-api.eapi.joincoded.com/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Prepare your request body here, you can use JSON or FormData
        let parameters: [String: Any] = [
            "username": username,
            "password": password,
            "image": imageURL
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error serializing JSON: \(error.localizedDescription)")
            return
        }
        
        // Send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response here
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
                // Handle the response status code as needed
            }
            
            // Handle the response data if needed
            if let data = data, let responseData = String(data: data, encoding: .utf8) {
                print("Response data: \(responseData)")
            }
        }.resume()
    }
}

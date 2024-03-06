//
//  dViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by maha on 06/03/2024.
//
import UIKit

class ProfileViewController: UIViewController {
    
    var token : String?

    // Labels to display user information
    let usernameLabel = UILabel()
    let balanceLabel = UILabel()

    // User information properties
    let username: String? = nil
    var balance: Double = 0.0



    override func viewDidLoad() {
        super.viewDidLoad()

        
        usernameLabel.text = "Username: \(username)"
        balanceLabel.text = "Balance: $\(balance)"

        
        usernameLabel.frame = CGRect(x: 20, y: 100, width: 300, height: 30)
        balanceLabel.frame = CGRect(x: 20, y: 150, width: 300, height: 30)

        
        view.addSubview(usernameLabel)
        view.addSubview(balanceLabel)
    }
}

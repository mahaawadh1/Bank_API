//
//  withdrow.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by maha on 06/03/2024.
//
import UIKit
import Eureka

class WithdrawalViewController: FormViewController {
    
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupForm()
    }
    
    private func setupForm() {
        form +++ Section("Withdrawal")
        <<< DecimalRow() { row in
            row.title = "Withdraw Amount"
            row.placeholder = "Enter amount to withdraw"
            row.tag = "withdraw"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
        form +++ Section()
        <<< ButtonRow(){ row in
            row.title = "Withdraw"
            row.onCellSelection { _, _ in
                self.submitTapped()
            }
        }
    }
    
    @objc func submitTapped() {
        let errors = form.validate()
        guard errors.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Please enter a valid number")
            return
        }
        
        guard let amountChange = (form.rowBy(tag: "withdraw") as? DecimalRow)?.value else {
            return
        }
        
        // Now 'amountChange' holds the withdrawal amount extracted from the form
        
        guard let token = token else {
            // Handle the case where token is nil, perhaps show an error message or return from the function
            print("Token is nil")
            return
        }
        
        // Assuming 'token' is of type String, you can use it here
        NetworkManager.shared.withdraw(token: token, amountChange: AmountChange(amount: amountChange)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    let profileVC = ProfileViewController()
                    self.navigationController?.pushViewController(profileVC, animated: true)
                    
                case .failure(let error):
                    print("Withdrawal failed: \(error)")
                }
            }
        }
    }

    
    private func presentAlertWithTitle(title: String, message: String, completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { _ in
            completionHandler?()
        })
        self.present(alert, animated: true, completion: nil)
    }
}

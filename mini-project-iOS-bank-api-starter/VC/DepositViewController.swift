//
//  depo.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by maha on 06/03/2024.
//
import UIKit
import Eureka
import Alamofire

class DepositViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        setupForm()
    }
    
    
    private func setupForm(){
        form +++ Section("DEPOSIT")
        <<< DecimalRow() { row in
            row.title = "Deposit Amount"
            row.placeholder = "Enter amount to deposit"
            row.tag = "deposit"
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
            row.title = "Deposit"
            row.onCellSelection{cell, row in
                self.submitTapped()
            }
        }
    }
    @objc func submitTapped() {
        let depositRow: DecimalRow? = form.rowBy(tag: "deposit")
        
        
        let errors = form.validate()
        guard errors.isEmpty else {
            print(errors)
            presentAlertWithTitle(title: "Error", message: "Please type a valid number")
            return
        }
        
        let token = TokenResponse(token: "\(TokenResponse.init(token: ""))")
    }
    
    private func presentAlertWithTitle(title: String, message: String, completionHandler: (() -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { _ in
                completionHandler?()
            })
            self.present(alert, animated: true, completion: nil)
        }
}

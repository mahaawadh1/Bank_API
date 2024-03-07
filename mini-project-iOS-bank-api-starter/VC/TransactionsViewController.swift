//
//  TViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by maha on 07/03/2024.
//

import UIKit

class TransactionsViewController: UITableViewController {

    private var transactions: [Transaction] = []
    var token: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchTransactions()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) // Correct identifier
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = "Type: \(transaction.type), Amount: \(transaction.amount)"
        return cell
    }

    private func fetchTransactions() {
        print("Fetching transactions...")
        guard let token = token else {
            print("User token is missing.")
            return
        }

        NetworkManager.shared.getTransactions(token: token) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let transactions):
                    print("Transactions received: \(transactions)")
                    self.transactions = transactions
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch transactions: \(error)")
                }
            }
        }
    }
}

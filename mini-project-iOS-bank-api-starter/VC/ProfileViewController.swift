//
//  dViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by maha on 06/03/2024.
//
import UIKit
import SnapKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    var user: User?
    var account: Account?
    var token: String?
    
    let usernameLabel = UILabel()
    let emailLabel = UILabel()
    let balanceLabel = UILabel()
    
    
    let profileImageView = UIImageView()
    let widthrawButton = UIButton(type: .system)
    let depositButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " User Profile "
        view.backgroundColor = .white
        
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(balanceLabel)
        
        
        view.addSubview(profileImageView)
        view.addSubview(widthrawButton)
        view.addSubview(depositButton)
        
        setupViews()
        setupLayout()
        fetch()
        setupNavBar()
        
        
    }
    
    
    private func setupViews() {
        widthrawButton.addTarget(self, action: #selector(widthrawButtonTapped), for: .touchUpInside)
        depositButton.addTarget(self, action: #selector(depositButtonTapped), for: .touchUpInside)
    
        profileImageView.image = UIImage(named: "nm")
        profileImageView.layer.cornerRadius = 37.5
        profileImageView.clipsToBounds = true
        usernameLabel.font = .systemFont(ofSize: 20, weight: .medium) // Change font size to 20
        emailLabel.font = .systemFont(ofSize: 20, weight: .medium) // Change font size to 20
        balanceLabel.font = .systemFont(ofSize: 20, weight: .medium) // Change font size to 20
        
        widthrawButton.setTitle(" WITHDRAW 💰", for: .normal)
        widthrawButton.backgroundColor = .red
        widthrawButton.layer.cornerRadius = 5
        widthrawButton.setTitleColor(.white, for: .normal)
        
        depositButton.setTitle(" DEPOSIT 💲", for: .normal)
        depositButton.backgroundColor = .systemGreen
        depositButton.layer.cornerRadius = 5
        depositButton.setTitleColor(.white, for: .normal)
    }
    
    
    private func setupLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20) // Placed at the top with an offset of 20
            make.width.height.equalTo(180)
            profileImageView.layer.cornerRadius = 10
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(15) // Placed below profileImageView with an offset of 20
        }
        
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameLabel.snp.bottom).offset(15) // Placed below usernameLabel with an offset of 20
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailLabel.snp.bottom).offset(15) // Placed below emailLabel with an offset of 20
        }
        
        widthrawButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(balanceLabel.snp.bottom).offset(40) // Placed below balanceLabel with an offset of 40
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(60)
        }
        
        depositButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(widthrawButton.snp.bottom).offset(20) // Placed below widthrawButton with an offset of 20
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(60)
        }
    }
    
    private func configure(){
        usernameLabel.text = "User name:  \(user?.username ?? "")"
        emailLabel.text = "User email: \(user?.email ?? "") "
        balanceLabel.text = "user balance: "
        widthrawButton.setTitle("widthraw", for: .normal)
        depositButton.setTitle("deposit", for: .normal)
    }
    @objc private func widthrawButtonTapped() {
        let widthrawViewController = WithdrawalViewController()
        widthrawViewController.modalPresentationStyle = .popover
        if let popoverController = widthrawViewController.popoverPresentationController {
            popoverController.sourceView = self.widthrawButton
            popoverController.sourceRect = self.widthrawButton.bounds
            popoverController.permittedArrowDirections = .any
        }
        present(widthrawViewController, animated: true, completion: nil)
    }
    
    @objc private func depositButtonTapped() {
        let depositViewController = DepositViewController()
        depositViewController.modalPresentationStyle = .popover
        if let popoverController = depositViewController.popoverPresentationController {
            popoverController.sourceView = self.depositButton
            popoverController.sourceRect = self.depositButton.bounds
            popoverController.permittedArrowDirections = .any
        }
        present(depositViewController, animated: true, completion: nil)
    }
    
    @objc private func transactionButtonTapped() {
        let transactionVC = TransactionsViewController()
        transactionVC.token = token
        self.navigationController?.pushViewController(transactionVC, animated: true)
    }
    private func fetch() {
        guard let token = token else {
            print("User token is missing.")
            return
        }
        
        NetworkManager.shared.fetchBank(token: token) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let accounts):
                    print(accounts)
                    self.usernameLabel.text = "Username: \(accounts.username)"
                    self.emailLabel.text = "Email: \(accounts.email)"
                    self.balanceLabel.text = "Balance: \(accounts.balance)"
                case .failure(let error):
                    print("Error fetching account: \(error.localizedDescription)")
                }
            }
        }
        
     
    }
    
    func setupNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.clipboard"), style: .plain, target: self, action: #selector(transactionButtonTapped)
        )
        navigationItem.rightBarButtonItem? .tintColor = UIColor.lightGray
    }
}

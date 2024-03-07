//
//  NetworkManager.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//
import Foundation
import Alamofire

class NetworkManager {
    private let baseUrl = "https://coded-bank-api.eapi.joincoded.com/"
    static let shared = NetworkManager()
    
    private init() {}
    
    func signup(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signup"
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signin(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signin"
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deposit(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "deposit"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).validate().response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func withdraw(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "withdraw"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).validate().response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchBank(token: String, completion: @escaping (Result<Account, Error>) -> Void) {
        let url = baseUrl + "account"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(url, method: .get,headers: headers).validate().responseDecodable(of: Account.self) { response in
            switch response.result {
            case .success(let accounts):
                completion(.success(accounts))
            case .failure(let error):
                completion(.failure(error))
                // EXTRA LINE FOR DEBUGGING
              if let data = response.data, let str = String(data: data, encoding: .utf8) {
                  print("Raw response: \(str)")
              }
            }
        }
        

        
    }
    func getTransactions (token: String, completion: @escaping (Result<[Transaction], Error>) -> Void) {
            let url = baseUrl + "transactions"
            let headers: HTTPHeaders = [.authorization(bearerToken: token)]

            AF.request (url, headers: headers).responseDecodable(of: [Transaction].self) { response in
                switch response.result {
                case .success(let transactions):
                    completion(.success (transactions))
                case .failure(let error):
                    completion(.failure (error))
                }
            }

        }
}

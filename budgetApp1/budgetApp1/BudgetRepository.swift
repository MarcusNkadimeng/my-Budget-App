//
//  BudgetRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import Foundation

typealias BudgetsResult = (Result<BudgetData, APIError>) -> Void
typealias AccountResult = (Result<AccountData, APIError>) -> Void

protocol BudgetRepositoryType: AnyObject {
    func getBudgets(completion: @escaping(BudgetsResult))
}

protocol AccountRepositoryType: AnyObject {
    func getAccounts(completion: @escaping(AccountResult))
}

class BudgetRepository: BudgetRepositoryType {
    
    func getBudgets(completion: @escaping (BudgetsResult)) {
        request(endpoint: "https://api.ynab.com/v1/budgets?access_token=t_Ikm7Q2U94be-lmSn4blgh1sjIEf1dMF7Tv8jguvpU", method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(endpoint: String, method: Method, completion: @escaping((Result<T, APIError>) -> Void)) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        call(with: request, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async() {
                    completion(.failure(.serverError))
                }
                return
            }
            do {
                guard let data = data else {
                    DispatchQueue.main.async() {
                        completion(.failure(.serverError))
                    }
                    return
                }
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async() {
                    completion(Result.success(object))
                }
            } catch {
                DispatchQueue.main.async() {
                    completion(Result.failure(.parsingError))
                }
            }
        }
        dataTask.resume()
    }
}

class AccountRepository: AccountRepositoryType {
    func getAccounts(completion: @escaping (AccountResult)) {
        request(endpoint: "https://api.ynab.com/v1/budgets/2b0c25e3-0d5e-411d-a019-2522faa22c2b/accounts?access_token=t_Ikm7Q2U94be-lmSn4blgh1sjIEf1dMF7Tv8jguvpU", method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(endpoint: String, method: Method, completion: @escaping((Result<T, APIError>) -> Void)) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        call(with: request, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async() {
                    completion(.failure(.serverError))
                }
                return
            }
            do {
                guard let data = data else {
                    DispatchQueue.main.async() {
                        completion(.failure(.serverError))
                    }
                    return
                }
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async() {
                    completion(Result.success(object))
                }
            } catch {
                DispatchQueue.main.async() {
                    completion(Result.failure(.parsingError))
                }
            }
        }
        dataTask.resume()
    }
}

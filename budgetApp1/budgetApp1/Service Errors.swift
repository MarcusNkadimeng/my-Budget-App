//
//  Service Errors.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import Foundation

enum APIError: String, Error {
    case internalError
    case serverError
    case parsingError
}

enum Method {
    case GET
    case POST
}

class APIHandler {
    static func request<T: Codable>(endpoint: String, method: Method, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        call(with: request, completion: completion)
    }
    
    private static func call<T: Codable>(with request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.serverError))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.serverError))
                }
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.parsingError))
                }
            }
        }
        dataTask.resume()
    }
}

struct URLConstants {
    static let accessToken = "?access_token=t_Ikm7Q2U94be-lmSn4blgh1sjIEf1dMF7Tv8jguvpU"
    static let baseURL = "https://api.ynab.com/v1/"
    static let budgetURL = baseURL + "budgets" + accessToken
    static let accountsURL = baseURL + "budgets/2b0c25e3-0d5e-411d-a019-2522faa22c2b/accounts" + accessToken
    static let transactionsURL = baseURL + "budgets/2b0c25e3-0d5e-411d-a019-2522faa22c2b/accounts/0515719a-f641-422b-8341-7073d5358dbe/transactions" + accessToken
    
}

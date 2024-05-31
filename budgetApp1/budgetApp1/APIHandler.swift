//
//  APIHandler.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/03.
//

import UIKit

// MARK: - API Handler
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

// MARK: - Http call type
enum Method {
    case GET
    case POST
}

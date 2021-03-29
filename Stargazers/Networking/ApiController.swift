//
//  ApiController.swift
//  Stargazers
//
//  Created by zsolt on 28/03/2021.
//

import Foundation

private enum CustomError: Error {
    case invalidUrl
    case responseError
    case missingData
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .responseError:
            return "Something went wrong. Try again later."
        case .missingData:
            return "Missing data."
        case .invalidUrl:
            return "Invalid URL."
        }
    }
}

class ApiController {
    struct GitHubApi {
        static let usersURL = URL(string: "https://api.github.com/repos")
    }
    
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    class func getStargazers(by owner: String, repo: String, completion: @escaping ((Result<[User]>) -> Void)) {
        let url = GitHubApi.usersURL?
            .appendingPathComponent(owner)
            .appendingPathComponent(repo)
            .appendingPathComponent("stargazers")

        guard let finalURL = url else {
            return completion(.failure(CustomError.invalidUrl))
        }

        var request : URLRequest = URLRequest(url: finalURL)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                completion(decode(responseData, error: responseError))
            }
        }
     
        task.resume()
    }

    class func decode(_ data: Data?, error: Error?) -> (Result<[User]>) {
        guard error == nil else {
            return (.failure(CustomError.responseError))
        }

        guard let jsonData = data else {
            return (.failure(CustomError.missingData))
        }

        do {
            let users = try JSONDecoder().decode([User].self, from: jsonData)
            return (.success(users))
        } catch {
            return (.failure(error))
        }
    }
    
}
